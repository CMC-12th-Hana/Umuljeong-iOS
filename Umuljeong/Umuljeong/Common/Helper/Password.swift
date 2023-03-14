//
//  Password.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import Foundation

public enum PasswordValidation {
    case eightCount
    case largeSmallEng
    case containInt
    case containSpecial
    case notMatch
    case error
    case pass
    
    var errorMessage: String? {
        switch self {
        case .eightCount:
            return "8자 이상 20자 이하로 입력해주세요"
        case .largeSmallEng:
            return "영문 대소문자를 포함해주세요"
        case .containInt:
            return "숫자를 포함해주세요"
        case .containSpecial:
            return "특수문자를 포함해주세요"
        case .error:
            return "조건 통과 실패"
        case .notMatch:
            return "두 비밀번호가 같지 않음"
         default:
            return nil
        }
    }
    
    var confirmPasswordErrorMessage: String? {
        switch self {
        case .notMatch:
            return "비밀번호와 일치하게 입력해주세요"
        case .error:
            return "조건 통과 실패"
         default:
            return nil
        }
    }
}
