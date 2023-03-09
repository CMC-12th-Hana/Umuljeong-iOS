//
//  TaskSummaryModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol SummaryModel {}

struct TaskSummaryModel: SummaryModel {
    let name:String
    let client:String
    let category:CategoryInfo
}



