//
//  JoinMemberBusinessViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import Foundation

class BusinessMemberListViewModel: ObservableObject {
    @Published var memberFeedInfo:[MemberDtoList] = []
    @Published var searchText:String = ""
    
    let repository = BusinessDetailRepository()
    
    func requestMember(businessId: Int) {
        repository.requestBusinessDetail(businessId: businessId) { result in
            switch result {
            case .success(let info):
                guard let memberList = info?.memberDtoList else {break}
                self.memberFeedInfo = memberList
            case .failure: break
            }
        }
    }
}
