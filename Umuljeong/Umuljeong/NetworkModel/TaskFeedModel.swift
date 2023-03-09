//
//  TaskFeedModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/07.
//

import Foundation

struct TaskFeedModel: Identifiable {
    let id: String = UUID().uuidString
    let taskNmae:String
    let categoryModel:CategoryModel
}
