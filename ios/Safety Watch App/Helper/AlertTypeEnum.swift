//
//  AlertTypeEnum.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 09/09/24.
//

import Foundation

// MARK: - Alert Type
enum AlertType {
    case UndoSOS(action: () -> Void)
    case Location(action: () -> Void)
    case UserInfo(action: () -> Void)
    case RemoveDevice(action: () -> Void)
    case ApiAlert(action: () -> Void, title: String, message: String)
    
    var title: String {
        switch self {
        case .UndoSOS:
            return "Thank you for reporting!"
        case .Location:
            return "Location Access Needed"
        case .UserInfo:
            return "Pairing Required"
        case .ApiAlert(action: let action, title: let title, message: let message):
            return title
        case .RemoveDevice:
            return "Alert"
        }
    }
    
    var message: String {
        switch self {
        case .UndoSOS:
            return "You can undo this report within 5 seconds if it was sent by mistake."
        case .Location:
            return "Please enable location access in the Watch app on your iPhone."
        case .UserInfo:
            return "Please open the Distress app on your device, then click the Pair button."
        case .ApiAlert(action: let action, title: let title, message: let message):
            return message
        case .RemoveDevice:
            return "The device has been removed from mobile app. "
        }
    }
    
    var actionName: String {
        switch self {
        case .UndoSOS:
            return "Undo"
        case .Location:
            return "Enable Location"
        case .UserInfo:
            return "Pair"
        case .ApiAlert:
            return "Ok"
        case .RemoveDevice:
            return "Ok"
        }
    }
    
    func performAction() {
        switch self {
        case .UndoSOS(let action):
            action()
        case .Location(let action):
            action()
        case .UserInfo(let action):
            action()
        case .ApiAlert(let action, let title, let message):
            action()
        case .RemoveDevice(let action):
            action()
        }
    }
}

