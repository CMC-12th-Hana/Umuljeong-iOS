//
//  FindPasswordService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol FindPasswordService {
    func requestCode(toPhoneNumber:String) -> 응답처리
    func requestIsAvailalable(code:String, ofPhoneNumber:String) -> 응답처리
    func registerNew(password:String) -> 응답처리
}

enum 응답처리 {
    case available
    case unavailable
}
