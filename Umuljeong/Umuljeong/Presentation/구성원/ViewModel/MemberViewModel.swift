//
//  MemberViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/10.
//

import Foundation
import Combine

class MemberViewModel: ObservableObject {
    @Published var memberFeedInfo:[UserInfoResponse] = []
    @Published var myInfo = UserInfoResponse(companyId: 0, memberId: 0, name: "", role: "", companyName: "", staffRank: "", phoneNumber: "", staffNumber: "")
    @Published var searchText: String = ""
    let myRepository = MemberMyDetailRepository()
    let memberRepository = MemberAllRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        requestMyinfo()
        requestAllMember()
        $searchText
            .sink { [weak self] _ in
                            self?.requestMemberSearch()
                        }
            .store(in: &cancellables)
    }
    
    
    //전체 구성원에서 나는 삭제하기
    func requestMyinfo() {
        myRepository.requestMyInfo { result in
            switch result {
            case .success(let myInfo):
                guard let info = myInfo else {break}
                self.myInfo = info
            case .failure(_):
                break
            }
        }
    }
    
    func requestAllMember() {
        memberRepository.requestMemberAll { response in
                switch response {
                case .success(let resMemberFeedInfo):
                    self.memberFeedInfo = resMemberFeedInfo?.profileDtoList ?? []
                    print(self.memberFeedInfo)
                    print("멤버_전체보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
                case .failure: break //애러 처리 미분류
                }
            }
    }
    
    func requestMemberSearch() {

        print("searchText 바뀔 때 마다 요청 중 / searchText 변경 확인 : \(searchText)")
    }
}
