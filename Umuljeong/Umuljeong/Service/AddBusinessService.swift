//
//  BusinessService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/11.
//

import Foundation

class AddBusinessService: ObservableObject {
    private var startDate: Date? = nil
    private var finishDate: Date? = nil
    private var memberIdList:[Int] = []
    
//    private var businessName: String = ""
//    private var significant: String = ""
//    private var revenue: String = ""
//    private var description: String = ""
    
    private let repository = BusinessAddRepository()
    
    static let shared = AddBusinessService()
    
    private init() {}
    
    //하나의 서비스를 두 ViewModel이 공유하고 있을 수 있도록 만들기
    
    
    //뷰 모델에서 날짜 받아올 메서드 //날짜 선택할 때 마다 API 적용 해서
    func resetDate() {
        self.startDate = nil
        self.finishDate = nil
    }
    
    func resetInfoData() {
        self.memberIdList = []
    }
    
    func setStartDate(startDate:Date?) {
        guard self.startDate != startDate else {return self.startDate = nil}
        self.startDate = startDate
    }
    
    func setFinishDate(finishDate: Date?) {
        guard self.finishDate != finishDate else {return self.finishDate = nil}
        self.finishDate = finishDate
    }
    
    func setMemberIdList(idList: [Int]) {
        self.memberIdList = idList
    }
    
    func getMemberIdList() -> [Int] {
        return self.memberIdList
    }
    
    func requestAddBusiness(clientId:Int, businessName:String, revenue: String, description: String, completion: @escaping ((Result<Bool, ResError>) -> Void)) {
        guard let start = startDate else {return}
        guard let finish = finishDate else {return}
        
        let startString:String = CalendarDateFomatter.date.string(from: start)
        let finishString:String = CalendarDateFomatter.date.string(from: finish)
        
        repository.requestBusinessAdd(clientId: clientId, businessInfo: BusinessInfo(name: businessName, businessPeriodDto: BusinessPeriodDto(start: startString, finish: finishString), memberIdList: self.memberIdList, revenue: Int(revenue) ?? 0, description: description)) { result in

                completion(result)
        }
//        print("적용됨 \(startDate) \(finishDate)")
//        print("AddMemberBusinessViewModel에서 추가한 IdList \(memberIdList) ")
//        print("businessName : \(businessName)")
//        print("revenue : \(revenue)")
//        print("description : \(description)")
    }
    
    //받아온 날짜 기준으로 검색하기
    //받은 데이터 ViewModel에 돌려주기
    
    
    
}
