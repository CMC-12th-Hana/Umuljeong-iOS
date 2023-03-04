//
//  LoginRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol LoginRepository {
    func requestLogin(loginInfo:LoginInfo, completion: @escaping (NetworkResult<Any>) -> Void)
}

protocol FindPasswordRepository {
    func requestCode(toPhoneNumber:String) -> 서버응답
    func requestIsAvailalable(code:String, ofPhoneNumber:String) -> 서버응답
    func requestRegisterNew(password:String) -> 서버응답
}


