//
//  SignupInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

struct SignupInfo: Codable {
    let name: String
    let phoneNumber: String
    let password :String
    let passwordCheck :String
}
