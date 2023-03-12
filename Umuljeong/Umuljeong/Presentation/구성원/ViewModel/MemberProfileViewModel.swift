//
//  DetailMemberViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/10.
//

import Foundation

class MemberProfileViewModel: ObservableObject {
    @Published var memberInfo = UserInfoResponse(companyId: 0, memberId: 0, name: "", role: "", companyName: "", staffRank: "", phoneNumber: "", staffNumber: "")
    let infoRepository = MemberOtherDetailRepository()
    let removeRepository = MemberRemoveRepository()

    func requestMemberInfo(memberId: Int , requestResult: @escaping (Bool) -> ()) {
        infoRepository.requestOtherMemberDetail(memberId: memberId) { result in
            switch result {
            case .success(let memberInfo):
                guard let info = memberInfo else {return requestResult(false)}
                self.memberInfo = info
                requestResult(true)
            case .failure(_):
                requestResult(false)
            }
        }
    }
    
    
    func requestMemberRemove(memberId: Int, requestResult: @escaping (Bool) -> ()){
        removeRepository.requestMemberRemove(memberId: memberId) { result in
            switch result {
            case .success:
                requestResult(true)
            case .failure(_):
                requestResult(false)
            }
        }
        
    }
    
    
}
