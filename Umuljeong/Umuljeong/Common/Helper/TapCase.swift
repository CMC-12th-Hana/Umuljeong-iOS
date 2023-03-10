//
//  TapCase.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import Foundation

enum TapCase {
    case username
    case phoneNumber
    case code
    case password
    case confirmPassword
    
    var usernameState:Bool {
        switch self {
        case .username:
            return true
        default:
            return false
        }
    }
    
    var phoneNumberState:Bool {
        switch self {
        case .phoneNumber:
            return true
        default:
            return false
        }
    }
    
    var codeState:Bool {
        switch self {
        case .code:
            return true
        default:
            return false
        }
    }
    
    var passwordState:Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
    
    var confirmPasswordState:Bool {
        switch self {
        case .confirmPassword:
            return true
        default:
            return false
        }
    }
}

enum CompanyTapCase {
    case company
    case email
}
