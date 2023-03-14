//
//  AddBusinessViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

class EditBusinessViewModel: ObservableObject {
    
//    @Binding var service: BusinessAddService?

    @Published var businessName: String = ""
    @Published var description:String = "" {
        didSet {
            print(description)
        }
    }
    @Published var revenue: String = ""
    
    let service = EditBusinessService.shared
    var businessInfo:BusinessDtoList?
    
    init() {
        self.service.resetInfoData()
    }
    
    func requestFixBusiness(businessId:Int, responseResult: @escaping (Bool) -> ()) {
        service.requestFixInfoBusiness(businessId: businessId, businessName: businessName, revenue: Int(revenue) ?? 0, description: self.description) { result in
            switch result {
            case .success:
                responseResult(true)
            case .failure:
                responseResult(false)
            }
        }
    }
    
    func requestBusinessInfo(businessId: Int, responseResult: @escaping (Bool) -> ()){
        service.requestInfoBusiness(businessId: businessId) { reqResult in
            switch reqResult {
            case .success(let businessInfo):
                guard let info = businessInfo else {return responseResult(false)}
                self.businessName = info.name
                self.description = info.description
                self.revenue = String(info.revenue)
                self.businessInfo = info
                responseResult(true)
            case .failure(_):
                responseResult(false)
            }
        }
    }
    
//    func getBeforeBusinessInfo() -> BusinessDtoList? {
//        return businessInfo
//    }

    func requestAddBusiness(clientId: Int, responseResult: @escaping (Bool) -> ()) {
        service.requestAddBusiness(clientId: clientId, businessName: self.businessName, revenue: self.revenue, description: self.description)
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
    
    func checkMemberCount() -> Int {
        return service.getMemberIdCount()
    }
}
