//
//  BusinessDateInfoService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol BusinessDateInfoService{
    func getBusinessSummary(forDate date: Date) -> [BusinessSummaryModel]
}
