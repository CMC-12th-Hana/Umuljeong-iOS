//
//  FixMemberProfileViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import Foundation

class FixMemberProfileViewModel:ObservableObject {
    @Published var nameText: String = ""
    @Published var phoneText: String = ""
    @Published var staffNumText: String = ""
    @Published var staffRank: String = ""
    @Published var memberId: Int = -1
    @Published var alertErrorMessage: String = "통신이 불안정합니다."
    
    let repository = LeaderFixMemberProfileRepository()
    
    func requestProfileFix(requestResult: @escaping (Bool) -> ()) {
        repository.requestMemberFix(memberId: memberId, name: nameText, phoneNumber: phoneText, staffNum: staffNumText, staffRank: staffRank) { result in
            switch result {
            case .success:
                requestResult(true)
            case .failure:
                requestResult(false)
            }
        }
    }
}
