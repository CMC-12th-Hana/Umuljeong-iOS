//
//  TaskDateInfoService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol TaskDateInfoService {
    func getTasksSummary(forDate date: Date) -> [TaskSummaryModel]
}

