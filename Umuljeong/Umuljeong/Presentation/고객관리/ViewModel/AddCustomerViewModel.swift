//
//  AddCustomerViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/08.
//

import Foundation

class AddCustomerViewModel: ObservableObject {
    @Published var customerName: String = ""
    @Published var customerMainCall: String = ""
    @Published var partName: String = ""
    @Published var partManagerName: String = ""
    @Published var partManagerCall: String = ""
    
//    @Published var alertNewWorkError: Bool = false
    
    func requestCustomerInfo(clientId:Int, requestResult: @escaping (Bool) -> ()) {
        let networkResult:Bool = true
        
        if networkResult == true {
            return requestResult(true) //성공하면 화면 돌아가기
        } else {
            return requestResult(false)
        }
    }
    
    
    func requestCreateNewCustomer(requestResult: @escaping (Bool) -> ()) {
        let networkResult:Bool = true
        
        if networkResult == true {
            return requestResult(true) //성공하면 화면 돌아가기
        } else {
            return requestResult(false)
        }
    }
    
    
    
    
    
}
