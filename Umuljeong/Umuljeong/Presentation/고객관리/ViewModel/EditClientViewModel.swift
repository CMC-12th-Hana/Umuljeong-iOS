//
//  AddClientViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/08.
//

import Foundation

class EditClientViewModel: ObservableObject {
    @Published var clientName: String = ""
    @Published var clientMainTel: String = ""
    @Published var department: String = ""
    @Published var partManagerName: String = ""
    @Published var partManagerTel: String = ""
    @Published var alertErrorMessage: String = "통신이 불안정합니다."
    
    //추가하기
    let addRepository = ClientAddRepository()
    
    //데이터 불러오기
    let infoRepository = ClientDetailRepository()
    //데이터 수정하기
    let fixRepository = ClientFixRepository()
    
//    @Published var alertNewWorkError: Bool = false
    
    func requestCustomerInfo(clientId:Int, requestResult: @escaping (Bool) -> ()) {
        infoRepository.requestClientDetail(clientId: clientId){ result in
            switch result {
            case .success(let clientInfo):
                    self.clientName = clientInfo?.name ?? ""
                    print(self.clientName) //client16
                    self.clientMainTel = clientInfo?.tel  ?? ""
                    self.department = clientInfo?.salesRepresentativeDto.department  ?? ""
                    self.partManagerName = clientInfo?.salesRepresentativeDto.name  ?? ""
                    self.partManagerTel = clientInfo?.salesRepresentativeDto.phoneNumber  ?? ""
                    requestResult(true)
            case .failure(.requestError(let message)): self.alertErrorMessage = "양식이 올바르지 않습니다."; requestResult(false)
            case .failure(.token):
                self.alertErrorMessage = "로그인 기간이 만료되었습니다. 다시 로그인 해주세요"; requestResult(false)
            }
        }
    }
    
    
    func requestCreateNewClient(requestResult: @escaping (Bool) -> ()) {
        addRepository.requestClientAdd(name: clientName, tel: clientMainTel, managerName: partManagerName, managerCall: partManagerTel, department: department) { result in
            switch result {
            case .success(_): requestResult(true)
            case .failure(.requestError(let message)): self.alertErrorMessage = "양식이 올바르지 않습니다."; requestResult(false)
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
