//
//  AddBusinessMemberViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import Foundation

class AddBusinessMemberViewModel: ObservableObject { //사업 추가 서비스의 멤버 초기화를 여기서 맡음
    @Published var searchText: String = "" {
        didSet {
            if searchText != oldValue {
                requestMemberSearch()
            }
        }
    }
    
    @Published var memberFeedInfo:[UserInfoResponse] = []
    @Published var leaderInfo:[UserInfoResponse] = []
    
    @Published var selectMemberInfo:[UserInfoResponse] = []
    @Published var deselectMemberInfo:[UserInfoResponse] = []
    
    let service = EditBusinessService.shared
    
    @Published var memberIdList:[Int] = []
    
    
    let repository = MemberAllRepository()
    
    init() {
        print("AddBusinessMemberViewModel 뷰모델 생성됨")
//        loadSelectIdList() <- 최초 생성시엔 늘 비어있기 때문에 빠른 동작 필요 X, 후에 수정하기 시 추가 
        requestAllMember()
    }
    
    func loadSelectIdList() {
        self.memberIdList = service.getMemberIdList()
        self.filterMember()
    }
    
    func setBeforeFixIdList(businessId: Int) {
//        service.setMemberIdList(idList: beforeInfo.memberDtoList.map{$0.id})
//        self.memberIdList = beforeInfo.memberDtoList.map{$0.id}
//        self.filterMember()
    }
    
    func resetViewModelIdListData() {
        memberIdList = []
        self.filterMember()
    }
    
    func saveMemberIdList() {
        service.setMemberIdList(idList: self.memberIdList)
    }
    
    func requestFixBusinessMember(beforeInfo: BusinessDtoList, reqResult:(Bool)->()) {
        

    }
    
    func requestAllMember() {
        repository.requestMemberAll { response in
                switch response {
                case .success(let resMemberFeedInfo):
                    self.memberFeedInfo = resMemberFeedInfo?.profileDtoList ?? []
//                    self.leaderInfo = self.memberFeedInfo.filter{$0.role == "리더"}
//                    self.memberFeedInfo = self.memberFeedInfo.filter{$0.role != "리더"}
                    self.filterMember()
//                    print(self.memberFeedInfo)
//                    print("멤버_전체보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
                case .failure: break //애러 처리 미분류
                }
            }
    }
    
    func filterMember() {
        deselectMemberInfo = memberFeedInfo.filter{!memberIdList.contains($0.memberId)}
        guard !memberIdList.isEmpty else {return}
        selectMemberInfo = memberFeedInfo.filter{memberIdList.contains($0.memberId)}
    }
    
    func selectMember(id: Int) {
        memberIdList.append(id)
        deselectMemberInfo = memberFeedInfo.filter{!memberIdList.contains($0.memberId)}
        selectMemberInfo += memberFeedInfo.filter{$0.memberId == id}
    }
    
    func deselectMember(id: Int) {
        memberIdList = memberIdList.filter{$0 != id}
        deselectMemberInfo = memberFeedInfo.filter{!memberIdList.contains($0.memberId)}
        selectMemberInfo = memberFeedInfo.filter{memberIdList.contains($0.memberId)}
    }
    
    func requestMemberSearch() {
        print("searchText 바뀔 때 마다 요청 중 / searchText 변경 확인 : \(searchText)")
    }
}
