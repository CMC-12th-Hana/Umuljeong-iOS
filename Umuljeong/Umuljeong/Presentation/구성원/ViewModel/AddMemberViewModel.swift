//
//  AddMemberViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/09.
//

import Foundation

class AddMemberViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var staffRank: String = ""
    @Published var staffNumber: String = ""
    
    let repository = MemberAddRepository()
    
    func requestAddMember(requestResult: @escaping (Bool) -> ()) {
        repository.requestMemberAdd(memberInfo: MemberInfo(name: name, phoneNumber: phoneNumber, staffRank: staffRank, staffNumber: staffNumber)) { result in
            switch result {
            case .success: requestResult(true)
            case .failure: requestResult(false)
            }
        }
    }
}
    
