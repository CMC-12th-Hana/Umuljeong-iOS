//
//  AddEventViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol AddEventViewModel {
    associatedtype Model:SummaryModel
    
    func add(to date: Date)
}
