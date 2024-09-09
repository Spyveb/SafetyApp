//
//  WatchConnecter.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 05/09/24.
//

import Foundation
import WatchConnectivity

class WatchConnector: NSObject, ObservableObject {

    static let shared = WatchConnector()
    public let session = WCSession.default
    var validateQrString = "qrData"
    @Published var userData: User?
    @Published var displayRemoveAlert = false

    override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
}

extension WatchConnector: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            debugPrint("Session activation failed with error: \(error.localizedDescription)")
            return
        }
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        dataReceivedFromPhone(userInfo)
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        dataReceivedFromPhone(message)
    }
}

// MARK: - Send Data to Watch
extension WatchConnector {

    public func sendDataToPhone(_ sendData: [String: Any]) {
        debugPrint("Sending Data :: \(sendData)")
        session.sendMessage(sendData, replyHandler: nil)
    }

    public func dataReceivedFromPhone(_ info: [String: Any]) {
        for (key, value) in info {
            switch key {
            case "qr_data":
                debugPrint("Key :: \(key)")
                debugPrint("Value :: \(value)")
                debugPrint("QR String :: \(validateQrString)")
                sendDataToPhone(["qr_valid": (value as? String == validateQrString)])

            case "user_data":
                debugPrint("Key :: \(key)")
                debugPrint("Value :: \(value)")
                handleUserData(value)

            case "remove_device":
                debugPrint("Key :: \(key)")
                debugPrint("Value :: \(value)")
                if value as? Bool ?? false {
                    DispatchQueue.main.async {
//                        defaultAlert = .ApiAlert(action: {
                        self.displayRemoveAlert = true
                        UserDefaults.standard.removeObject(forKey: "Saved_User_Data")
                        UserDefaults.standard.set(false, forKey: "Is_Saved_User_Data")
                        self.userData = nil
//                        }, title: "Failure", message: "Unauthorised" )
//                        showAlert = true
                    }
                }

            default:
                debugPrint("Key :: \(key)")
            }
        }
    }

    private func handleUserData(_ value: Any) {
        if let messageData = value as? [String: Any] {
            do {
                let userId = Int(messageData["user_id"] as? String ?? "0") ?? 0
                let userName = messageData["user_name"] as? String
                let userToken = messageData["user_token"] as? String
                
                let userData = User(userId: userId, userName: userName, userToken: userToken)
                if userData.userId != 0 && userData.userToken != nil {
//                    userData.userToken = userToken ?? ""
//                    userData.userName = userName ?? ""
                    if let encodeUserData = try? JSONEncoder().encode(userData) {
                        DispatchQueue.main.async {
                            self.userData = userData
                            self.sendDataToPhone(["user_data_saved": true])
                            UserDefaults.standard.setValue(encodeUserData, forKey: "Saved_User_Data")
                            UserDefaults.standard.setValue(true, forKey: "Is_Saved_User_Data")
                            UserDefaults.standard.synchronize()
                        }
                    }
                } else {
                    sendDataToPhone(["user_data_saved": false])
                }
                debugPrint("User Data :: \(userData)")
            } catch {
                sendDataToPhone(["user_data_saved": false])
                debugPrint("Failed to decode User: \(error)")
            }
        }
    }
}

