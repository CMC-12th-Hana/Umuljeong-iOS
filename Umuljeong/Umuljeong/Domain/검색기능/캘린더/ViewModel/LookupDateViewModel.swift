//
//  LookupDateViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import Foundation

protocol LookupDateViewModel {
    associatedtype Model:SummaryModel
    
    func load(for date: Date) -> [Model]
}

