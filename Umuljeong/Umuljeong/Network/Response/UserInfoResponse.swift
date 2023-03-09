//
//  UserInfoResponse.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/09.
//

import Foundation

struct MemberAllInfoResponse: Codable {
    let profileDtoList: [UserInfoResponse]
}

struct UserInfoResponse: Codable {
    let companyId: Int
    let name, role, companyName, staffRank: String
    let phoneNumber, staffNumber: String
}


