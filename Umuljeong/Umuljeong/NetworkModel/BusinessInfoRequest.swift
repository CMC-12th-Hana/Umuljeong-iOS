//
//  BusinessInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation

struct BusinessInfoRequest {
    var name:String
    var businessPeriodDto:BusinessPeriodDto
    var memberIdList:[Int]
    var revenue:Int
    var description:String
}

struct BusinessPeriodDto: Codable {
    var start:String
    var finish:String
}


