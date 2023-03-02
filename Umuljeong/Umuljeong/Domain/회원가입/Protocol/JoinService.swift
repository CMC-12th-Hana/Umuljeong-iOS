//
//  JoinService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol JoinService {
    func requestCode(toPhoneNumber:String) -> 응답처리
    func requestIsAvailalable(code:String, ofPhoneNumber:String) -> 응답처리
    func requestJoin(signInInfo: SignInInfo) -> 응답처리
}
//
//enum CodeVerificationResult {
//    case available
//    case unavailable
//}
//
//enum JoinResult {
//    case available
//    case unavailable
//}
