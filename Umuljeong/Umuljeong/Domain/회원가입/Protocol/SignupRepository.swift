//
//  SignupRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol SignupRepository {
    func requestCode(toPhoneNumber:String) -> NetworkResult<Any>
    func requestIsAvailalable(code:String, ofPhoneNumber:String) -> NetworkResult<Any>
    func requestSignup(singupInfo: SignupInfo, completion: @escaping (NetworkResult<Any>) -> Void)
}



enum 서버요청 {
    
}

enum 서버응답 {
    
}





