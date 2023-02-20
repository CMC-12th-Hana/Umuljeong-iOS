//
//  TeskModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/17.
//

import Foundation

struct TeskModel: Identifiable {
    let id: String = UUID().uuidString
    let work:String
    let customer:String
    let category:String
}
