//
//  JoinInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

struct SignInInfo: Identifiable, Codable {
    var id: String
    var name: String
    var phoneNumber:String
    var password:String
}
