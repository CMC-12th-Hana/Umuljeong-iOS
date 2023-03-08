//
//  AddClientViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/08.
//

import Foundation

class AddClientViewModel: ObservableObject {
    @Published var customerName: String = ""
    @Published var customerMainCall: String = ""
    @Published var partName: String = ""
    @Published var partManagerName: String = ""
    @Published var partManagerCall: String = ""
    @Published var alertErrorMessage: String = ""
    
    let addRepository = ClientAddRepository()
    
//    @Published var alertNewWorkError: Bool = false
    
    func requestCustomerInfo(clientId:Int, requestResult: @escaping (Bool) -> ()) {
        let networkResult:Bool = true
        
        if networkResult == true {
            return requestResult(true) //성공하면 화면 돌아가기
        } else {
            return requestResult(false)
        }
    }
    
    
    func requestCreateNewClient(requestResult: @escaping (Bool) -> ()) {
        addRepository.requestClientAdd(name: customerName, tel: customerMainCall, managerName: partManagerName, managerCall: partManagerCall, department: partName) { result in
            switch result {
            case .success(let a): requestResult(a)
            case .failure(.requestError(let message)): self.alertErrorMessage = message; requestResult(false)
            case .failure(.token):
                self.alertErrorMessage = "로그인 기간이 만료되었습니다. 다시 로그인 해주세요"; requestResult(false)
            }
            }
    }

        
    
    func requestEditClient(requestResult: @escaping (Bool) -> ()) {
        let networkResult:Bool = true
        
        if networkResult == true {
            return requestResult(true) //성공하면 화면 돌아가기
        } else {
            return requestResult(false)
        }
    }
    
    
    
    
    
}
