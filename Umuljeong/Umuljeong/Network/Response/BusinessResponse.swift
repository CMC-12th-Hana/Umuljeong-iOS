//
//  BusinessResponse.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import Foundation

// MARK: - BusinessListResponse
struct BusinessListResponse: Codable {
    let businessDtoList: [BusinessDtoList]
}

// MARK: - BusinessDtoList
struct BusinessDtoList: Codable {
    let businessId: Int
    let clientName: String
    let name: String
    let businessPeriodDto: BusinessPeriodDto
    let revenue: Int
    let memberDtoList: [MemberDtoList]
    let description: String
}

// MARK: - MemberDtoList
struct MemberDtoList: Codable {
    let id: Int
    let name: String
}
