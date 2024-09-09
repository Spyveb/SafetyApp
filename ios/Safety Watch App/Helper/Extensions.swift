//
//  Extensions.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 09/09/24.
//

import Foundation
import SwiftUI

extension View {
    
    // MARK: - Fetch UserInfo
    func  fetchUserInfo() -> User? {
        var userData: User?
        
        if UserDefaults.standard.bool(forKey: "Is_Saved_User_Data") {
            let encodedData = UserDefaults.standard.data(forKey: "Saved_User_Data")
            do {
                userData = try JSONDecoder().decode(User.self, from: encodedData!)
            } catch {
                debugPrint("Unable to decode data")
            }
        }
        return userData
    }
    
    // MARK: - Create form data body
    func createFormDataBody(withParameters parameters: [String: String], boundary: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

struct RedButton: ButtonStyle {
    var widthAndHeight = CGFloat()
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: widthAndHeight, height: widthAndHeight)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(Circle())
    }
}

struct CustomEnvironmentKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.0
}

extension EnvironmentValues {
    var customValue: CGFloat {
        get { self[CustomEnvironmentKey.self] }
        set { self[CustomEnvironmentKey.self] = newValue }
    }
}
