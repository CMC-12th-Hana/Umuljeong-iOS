//
//  CategoryResponse.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/14.
//

import Foundation

struct CategoryResponse: Codable {
    let taskCategoryDtoList: [TaskCategoryDtoList]
    let count: Int
}

struct TaskCategoryDtoList: Codable {
    let taskCategoryId: Int
    let name, color: String
}
