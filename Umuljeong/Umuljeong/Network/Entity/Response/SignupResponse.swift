//
//  TokenResponse.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import Foundation

struct SignupResponse: Codable {
    let memberId: Int?
    let accessToken: String?
}
