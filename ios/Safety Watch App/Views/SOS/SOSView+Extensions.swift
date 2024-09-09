//
//  SOSView+Extensions.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 09/09/24.
//

import Foundation
import SwiftUI
import EFQRCode

extension SOSView {
    
    /// Generate random string
    func generateRandomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = (0..<32).map{ _ in String(letters.randomElement()!) }.reduce("", +)
        DispatchQueue.main.async {
            viewModel.validateQrString = randomString
        }
        //        return "qrData"
        return randomString
    }
    
    /// Generate QR image
    func generateQRCode(from string: String) -> UIImage? {
        if let cgImage = EFQRCode.generate(
            for: string,
            size: EFIntSize(width: 300, height: 300), backgroundColor: UIColor.clear.cgColor
        ) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    /// SOS action
    func sosAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if !isUndoTapped {
                debugPrint("Perform sos action")
                isSosSuccessful = true
                showAlert = false
                let params = [
                    "city": locationManager.city,
                    "location": locationManager.locationName,
                    "latitude": String(locationManager.location?.coordinate.latitude ?? 0.0),
                    "longitude": String(locationManager.location?.coordinate.longitude ?? 0.0)
                ]
                postAPICall(urlString: "https://lightslategray-bear-191841.hostingersite.com/public/api/create_sos_emergency_case", parameters: params, responseModel: APIResponse.self) { status, responseData, error in
                    if status {
                        if responseData?.success ?? false {
                            DispatchQueue.main.async {
                                defaultAlert = .ApiAlert(action: {}, title: "Success", message: responseData?.message ?? "Your SOS message has been sent. Help is on the way. Stay safe and keep your phone nearby." )
                                showAlert = true
                            }
                        } else {
                            DispatchQueue.main.async {
                                defaultAlert = .ApiAlert(action: {}, title: "Alert", message: responseData?.message ?? "Failed to send SOS emergency" )
                                showAlert = true
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            defaultAlert = .ApiAlert(action: {}, title: "Failure", message: responseData?.message ?? "Failed to send SOS emergency" )
                            showAlert = true
                        }
                    }
                }
            }
        }
    }
    
    /// Token Check API Call
    func validToken() {
        postAPICall(urlString: "https://lightslategray-bear-191841.hostingersite.com/public/api/check_token", responseModel: APIResponse.self) { status, response, errorMessage in
            debugPrint("Response :: \(String(describing: response))")
            if status {
                if response?.success ?? false {
                    isTokenValid = true
                } else {
                    removeData()
                }
            }
        }
    }
    
    /// Remove Data
    func removeData() {
        DispatchQueue.main.async {
            defaultAlert = .ApiAlert(action: {
                UserDefaults.standard.removeObject(forKey: "Saved_User_Data")
                UserDefaults.standard.set(false, forKey: "Is_Saved_User_Data")
                viewModel.userData = nil
            }, title: "Authorization Error", message: "Todo" ) /// Todo
            showAlert = true
        }
    }
    
}

extension SOSView {
    
    // MARK: - API Call
    func postAPICall<T: Decodable>(
        urlString: String,
        httpMethod: String = "POST",
        parameters: [String: String]? = nil,
        responseModel: T.Type,
        completion: @escaping ((Bool, _ response: T?, _ errorMessage: String?) -> Void))
    {
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
            completion(false, nil, "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let token = viewModel.userData?.userToken ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        if let parameters = parameters {
            let formDataBody = createFormDataBody(withParameters: parameters, boundary: boundary)
            request.httpBody = formDataBody
            debugPrint("Params :: \(parameters)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint("Error making API call: \(error)")
                completion(false, nil, error.localizedDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200, let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(responseModel, from: data)
                        DispatchQueue.main.async {
                            completion(true, responseData, nil)
                        }
                    } catch {
                        debugPrint("Error decoding response data: \(error)")
                        DispatchQueue.main.async {
                            completion(false, nil, "Failed to decode response")
                        }
                    }
                } else if httpResponse.statusCode == 401 {
                    removeData()
                } else {
                    debugPrint("Unexpected status code: \(httpResponse.statusCode)")
                    DispatchQueue.main.async {
                        completion(false, nil, "Error: \(httpResponse.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
}


//func sosAPI() {
//    guard let url = URL(string: "https://lightslategray-bear-191841.hostingersite.com/public/api/create_sos_emergency_case") else {
//        debugPrint("Invalid URL")
//        return
//    }
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    let boundary = UUID().uuidString
//    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//    //        let token = viewModel.userData?.userToken ?? ""
//    //        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//    request.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTMwNWQzNjMyYmU0MjFlMTY4MDJiYmNhNzhmOWVhMjNiNWRhNzFhZWVkM2I5YjExN2Q3OWIzYjMxNTY5ZWYxOTg0NzJiYjlkODU4MjBkNzciLCJpYXQiOjE3MjU1NDM3OTQuOTgzMDQ5LCJuYmYiOjE3MjU1NDM3OTQuOTgzMDUsImV4cCI6MTc1NzA3OTc5NC45ODAyODUsInN1YiI6IjgiLCJzY29wZXMiOltdfQ.EFY9OZgdpsYOVCw1ODYF19oq8C_JBxMxLG2jqRnpHGKNEEB3T7JkG7dFq-ERdReQjd9oEC_-82vsyQV_r9Fs63kg0Mcvrat8s6Pl9Uh6ThVxOz-R_-zJogaVTbWdUe0lR0zaplZZYFGWwu7lS5EaJgbrNSvu1tNcCS54B9y_n4xAk3FcZJ_rCrMgG7L0KNClhxy7sVZvAn9nHsBJx1C8Bh3Z6HfPN3dPQjdCjFQrVYl_taR21p-PKJSS9cey0dWqaJ9EO1kUGqWuPGzYn07dAH3IsBI6XKRCNZmKI5ZdsSsXZsRZoXgJS2F1L91mPT1y_Yc_5Ezxuu8s7rc-tx6iFkqfVwIMAAsRhVRaCjcKbd024_uXzr5dnhLgyRKfLMuPByVEHL_YoIf0yxxKdoPdoW4hWu30Gk_A2SFbq09zBfbH7J3Ge_flNpzUMtaAFhrMB5u6hQYVwitFX58gkUk792qNEVBvYGb1QA-ENDGhj2yU_osR71tE3jsg4qyKcK_pnLKNJoknK7GCxeo8PuSoqN76ZwccnTN8hGX0vKmdxCuoXaoelkLKfSP86wYzn5QeSPTwdCmKDI7e3afGJv8mGLcsvHenIb6wZinZ14gXGFxtYhy0_5WkA5e3MEyC6XXKby9IciaXtdVKwqpgWRFPa-ygKZtqwIKyPAjg6NRcx7c", forHTTPHeaderField: "Authorization")
//
//
//    let formDataBody = createFormDataBody(withParameters: [
//        "city": locationManager.city,
//        "location": locationManager.locationName,
//        "latitude": String(locationManager.location?.coordinate.latitude ?? 0.0),
//        "longitude": String(locationManager.location?.coordinate.longitude ?? 0.0)
//    ], boundary: boundary)
//
//    request.httpBody = formDataBody
//    debugPrint("Param :: \(formDataBody)")
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//        if let error = error {
//            debugPrint("Error making API call: \(error)")
//            return
//        }
//
//        let dataString = String(data: data!, encoding: .utf8)
//        print("Raw Response Data: \(dataString ?? "No data")")
//
//        if let httpResponse = response as? HTTPURLResponse {
//            if httpResponse.statusCode == 200 {
//                debugPrint("Status code 200 - OK")
//                debugPrint(String(data: data!, encoding: .utf8) as Any)
//                if let data = data {
//                    do {
//                        let responseData = try JSONDecoder().decode(APIResponse.self, from: data)
//                        debugPrint("Response data: \(responseData)")
//                        if responseData.success {
//                            DispatchQueue.main.async {
//                                defaultAlert = .ApiAlert(action: {}, title: "Success", message: responseData.message )
//                                showAlert = true
//                            }
//                        } else {
//                            DispatchQueue.main.async {
//                                defaultAlert = .ApiAlert(action: {}, title: "Failure", message: responseData.message )
//                                showAlert = true
//                            }
//                        }
//                    } catch {
//                        DispatchQueue.main.async {
//                            defaultAlert = .ApiAlert(action: {}, title: "Failure", message: "Failed to send SOS emergency" )
//                            showAlert = true
//                        }
//                        debugPrint("Error decoding response data: \(error)")
//                    }
//                }
//
//            } else if httpResponse.statusCode == 401 {
//                DispatchQueue.main.async {
//                    defaultAlert = .ApiAlert(action: {
//                        UserDefaults.standard.removeObject(forKey: "Saved_User_Data")
//                        UserDefaults.standard.set(false, forKey: "Is_Saved_User_Data")
//                        viewModel.userData = nil
//                    }, title: "Failure", message: "Unauthorised" )
//                    showAlert = true
//                }
//
//            } else {
//                DispatchQueue.main.async {
//                    defaultAlert = .ApiAlert(action: {}, title: "Failure", message: "\(httpResponse.statusCode)" )
//                    showAlert = true
//                }
//                debugPrint("Unexpected status code: \(httpResponse.statusCode)")
//            }
//        }
//    }
//
//    task.resume()
//
//}
