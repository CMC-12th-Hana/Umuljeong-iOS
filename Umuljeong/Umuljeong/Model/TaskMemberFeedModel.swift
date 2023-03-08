//
//  TaskMemberFeedModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/07.
//

import Foundation

struct TaskMemberFeedModel: Identifiable {
    let id: String = UUID().uuidString
    let memberName:String
    let taskList:[TaskFeedModel]
}
