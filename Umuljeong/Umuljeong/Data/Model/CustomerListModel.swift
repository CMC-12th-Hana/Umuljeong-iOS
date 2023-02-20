//
//  CustomerListModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import Foundation

struct CustomerListModel: Identifiable {
    let id: String = UUID().uuidString
    let customer:String
    let visitCount:Int
    let businessCount:Int
}
