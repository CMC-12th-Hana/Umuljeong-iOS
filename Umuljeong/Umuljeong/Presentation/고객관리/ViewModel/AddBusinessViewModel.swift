//
//  AddBusinessViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

class AddBusinessViewModel: ObservableObject {
    
//    @Binding var service: BusinessAddService?

    @Published var businessName: String = ""
    @Published var description:String = ""
    @Published var revenue: String = ""
    
    init() {
        AddBusinessService.shared.resetInfoData()
    }
    

    func requestAddBusiness(clientId: Int, responseResult: @escaping (Bool) -> ()) {
        AddBusinessService.shared.requestAddBusiness(clientId: clientId, businessName: self.businessName, revenue: self.revenue, description: self.description)
        { result in
            switch result {
            case .success:
                responseResult(true)
                print("사업추가성공")
            case .failure(_):
                responseResult(false)
                print("사업추가실패")
            }
        }
    }
}
