//
//  SignupService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol SignupService {
//    func requestCode(toPhoneNumber:String) -> 응답처리
//    func requestIsAvailalable(code:String, ofPhoneNumber:String) -> 응답처리
    func requestSignup(signupInfo: SignupInfo, completion: @escaping (NetworkResult<Any>) -> Void)
}

