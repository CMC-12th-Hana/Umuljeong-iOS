//
//  BusinessInfo.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/05.
//

import Foundation

struct BusinessInfo {
    var name:String
    var businessPeriodDto:BusinessPeriodDto
    var memberIdList:[Int]
    var revenue:Int
    var description:String
    
    struct BusinessPeriodDto {
        var start:String
        var finish:String
    }
}

