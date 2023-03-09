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
    
    func requestAddMember(clientId: Int) {
        
    }
    
    
    
}
