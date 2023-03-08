//
//  ClientInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation

struct ClientInfoFeedResponse: Codable {
    let clientCompanyDtoList:[ClientInfo]
}

struct ClientInfo: Codable {
    let clientId: Int
    let name, tel: String
    let salesRepresentativeDto: SalesRepresentativeDto
    let taskCount: Int
    let businessCount: Int
}

struct SalesRepresentativeDto: Codable {
    let name, phoneNumber, department: String
}


