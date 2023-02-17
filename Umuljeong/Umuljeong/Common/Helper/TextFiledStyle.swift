//
//  TextFiledStyle.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import SwiftUI

enum TextFiledStyle {
    case username
    case email
    case phoneNumber
    case password
    case confirmPassword
    
   var type: String {
        switch self {
        case .username:
            return "이름"
        case .email:
            return "이메일"
        case .phoneNumber:
            return "휴대폰 번호"
        case .password:
            return "비밀번호"
        case .confirmPassword:
            return "비밀번호 재입력"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .username:
            return "이름을 입력해주세요"
        case .email:
            return "이메일을 입력해주세요"
        case .phoneNumber:
            return "숫자만 입력해주세요"
        case .password:
            return "비밀번호 입력"
        case .confirmPassword:
            return "비밀번호 재입력"
        }
    }
    
    var isPasswordField: Bool {
        switch self {
        case .username, .email, .phoneNumber:
            return false
        case .password, .confirmPassword:
            return true
        }
    }
}

