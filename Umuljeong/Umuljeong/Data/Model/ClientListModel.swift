//
//  CustomerListModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import Foundation

struct ClientListModel: Identifiable {
    let id: String = UUID().uuidString
    let clientName:String
    let taskCount:Int
    let businessCount:Int
}

