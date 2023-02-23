//
//  CatogoryModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/22.
//

import Foundation

struct CategoryModel: Identifiable, Equatable {
    let id: String = UUID().uuidString
    var catogoryName: String
    var categoryColor: CategoryColor
}
