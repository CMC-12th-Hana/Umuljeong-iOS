//
//  BusinessService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/11.
//

import Foundation

class EditBusinessService: ObservableObject {
    private var startDate: Date? = nil {
        didSet {
            guard let startDate = startDate else {return start = ""}
            start = CalendarDateFomatter.date.string(from: startDate)
            print(self.startDate)
        }
    }
    private var finishDate: Date? = nil {
        didSet {
            guard let finishDate = finishDate else {return finish = ""}
            finish = CalendarDateFomatter.date.string(from: finishDate)
            print(self.finishDate)
        }
    }
    private var start: String = ""
    private var finish: String = ""
    private var memberIdList:[Int] = []
    
//    private var businessName: String = ""
//    private var significant: String = ""
//    private var revenue: String = ""
//    private var description: String = ""
    
    private init() {}
    
    private let addRepository = BusinessAddRepository()
    private let fixRepository = BusinessFixRepository()
    private let detailRepository = BusinessDetailRepository()
    
    static let shared = EditBusinessService()
    
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
    
    func getMemberIdCount() -> Int {
        return self.memberIdList.count
    }
    
    func getDateInfo() -> (Date?,Date?) {
        return (startDate,finishDate)
    }
    
    //수정하려면 기존 정보가 있어야 함
    func requestInfoBusiness(businessId: Int, completion: @escaping ((Result<BusinessDtoList?, ResError>) -> Void)) {
        detailRepository.requestBusinessDetail(businessId: businessId) { reqResult in
            switch reqResult {
            case .success(let businessinfo):
                guard let businessinfo = businessinfo else {return completion(.failure(.FAILURE_NETWORK))}
                self.memberIdList = businessinfo.memberDtoList.map{$0.id} //요주의
                self.startDate = CalendarDateFomatter.date.date(from: businessinfo.businessPeriodDto.start)
                self.finishDate = CalendarDateFomatter.date.date(from: businessinfo.businessPeriodDto.finish)
                print(self.startDate)
                print(self.finishDate)
                completion(reqResult)
            case .failure(_):
                completion(reqResult)
            }
        }
    }
    
    
    
    func requestFixInfoBusiness(businessId: Int, businessName:String, revenue: Int, description: String, completion: @escaping ((Result<Bool, ResError>) -> Void)) {
        fixRepository.requestBusinessFix(businessId: businessId, businessInfo: BusinessInfoRequest(name: businessName, businessPeriodDto: BusinessPeriodDto(start: self.start, finish: self.finish), memberIdList: self.memberIdList, revenue: revenue, description: description)) { result in
            switch result {
            case .success:
                //수정 성공 후 모든 데이터 지우기
                print("수정요청")
                self.resetDate()
                self.resetInfoData()
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }
    
    func requestFixMemberBusiness(beforeInfo: BusinessDtoList, newMemberIdList: [Int], completion: @escaping ((Result<Bool, ResError>) -> Void)) {
        fixRepository.requestBusinessFix(businessId: beforeInfo.businessId, businessInfo: BusinessInfoRequest(name: beforeInfo.name, businessPeriodDto: BusinessPeriodDto(start: beforeInfo.businessPeriodDto.start, finish: beforeInfo.businessPeriodDto.finish), memberIdList: newMemberIdList, revenue: beforeInfo.revenue, description: beforeInfo.description)) { result in
            completion(result)
            switch result {
            case .success:
                //수정 성공 후 모든 데이터 지우기
                self.resetDate()
                self.resetInfoData()
            case .failure:
                break
            }
        }
    }
    
    func requestAddBusiness(clientId:Int, businessName:String, revenue: String, description: String, completion: @escaping ((Result<Bool, ResError>) -> Void)) {
        guard let start = startDate else {return}
        guard let finish = finishDate else {return}
//
        let startString:String = CalendarDateFomatter.date.string(from: start)
        let finishString:String = CalendarDateFomatter.date.string(from: finish)
        
        addRepository.requestBusinessAdd(clientId: clientId, businessInfo: BusinessInfoRequest(name: businessName, businessPeriodDto: BusinessPeriodDto(start: startString, finish: finishString), memberIdList: self.memberIdList, revenue: Int(revenue) ?? 0, description: description)) { result in

                completion(result)
        }
    }
    
    //받아온 날짜 기준으로 검색하기
    //받은 데이터 ViewModel에 돌려주기
    
    
    
}
