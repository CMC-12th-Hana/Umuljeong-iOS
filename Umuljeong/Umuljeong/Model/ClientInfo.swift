//
//  ClientInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation

struct ClientInfo: Codable {
    let name, tel: String
    let salesRepresentativeDto: SalesRepresentativeDto
}

struct SalesRepresentativeDto: Codable {
    let name, phoneNumber, department: String
}


