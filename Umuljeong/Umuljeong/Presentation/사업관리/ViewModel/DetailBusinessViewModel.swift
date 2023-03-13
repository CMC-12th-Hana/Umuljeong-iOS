//
//  BusinessDetailViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import Foundation

class DetailBusinessViewModel: ObservableObject {
    @Published var name:String = ""
    @Published var start:String = ""
    @Published var finish:String = ""
    @Published var revenue:String = ""
    @Published var description:String = "" {
        didSet {
            print(description)
        }
    }
    @Published var memberCount:Int = 0
//    var businessInfo: BusinessDtoList = BusinessDtoList(businessId: 0, name: "", businessPeriodDto: BusinessPeriodDto(start: "", finish: ""), revenue: 0, memberDtoList: [], description: "")
    
    private let detailRepository = BusinessDetailRepository()
    
    func requestInfoBusiness(businessId: Int, completion: @escaping ((Result<BusinessDtoList?, ResError>) -> Void)) {
        detailRepository.requestBusinessDetail(businessId: businessId) { reqResult in
            switch reqResult {
            case .success(let businessinfo):
                guard let businessinfo = businessinfo else {return completion(.failure(.FAILURE_NETWORK))}
//                self.businessInfo = businessinfo
                self.name = businessinfo.name
                self.start = businessinfo.businessPeriodDto.start //요주의
                self.finish = businessinfo.businessPeriodDto.finish //요주의
                self.revenue = String(businessinfo.revenue)
                self.description = businessinfo.description
                self.memberCount = businessinfo.memberDtoList.count
                completion(reqResult)
            case .failure(_):
                completion(reqResult)
            }
        }
    }
    
//    func getBusinessInfo() -> BusinessDtoList {
//        return self.businessInfo
//    }

    
    //사업 가져오기
    
}
