//
//  JoinRepository.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol JoinRepository {
    func requestCode(toPhoneNumber:String) -> 서버응답
    func requestIsAvailalable(code:String, ofPhoneNumber:String) -> 서버응답
    func requestJoin(signInInfo: SignInInfo) -> 서버응답
}

enum 서버요청 {
    
}

enum 서버응답 {
    
}





