//
//  ClientAllInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation

struct ClientAllInfo: Codable {
    let clientCompanyDtoList: [ClientCompanyDtoList]
}

struct ClientCompanyDtoList: Codable {
    let name, tel: String
    let salesRepresentativeDto: SalesRepresentativeDto
    let taskCount, businessCount: Int
}
