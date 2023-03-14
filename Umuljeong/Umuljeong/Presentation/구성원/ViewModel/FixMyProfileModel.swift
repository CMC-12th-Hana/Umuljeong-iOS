//
//  FixMemberViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/11.
//

import Foundation


class FixMyProfileModel:ObservableObject {
    @Published var nameText: String = ""
    @Published var phoneText: String = ""
    @Published var staffNumText: String = ""
    @Published var staffRank: String = ""
    @Published var alertErrorMessage: String = "통신이 불안정합니다."
    
    let memberRepository = MemberFixMyProfileRepository()
    let leaderRepository = LeaderFixMyProfileRepository()
    
    let myRoleLeader = ApiManager.shared.myRole() ?? false
    
    func requestProfileFix(requestResult: @escaping (Bool) -> ()) {
        if myRoleLeader { //리더일때 내 프로필 수정
            leaderRepository.requestLeaderInfoFix(name: nameText, phoneNumber: phoneText, staffNum: staffNumText, staffRank: staffRank) { result in
                switch result {
                case .success:
                    requestResult(true)
                case .failure:
                    requestResult(false)
                }
            }
        } else { //리더 아닐 때 내 프로필 수정
            memberRepository.requestMemberFix(name: nameText, staffNum: staffNumText, staffRank: staffRank) { result in
                switch result {
                case .success:
                    requestResult(true)
                case .failure:
                    requestResult(false)
                }
            }
        }
    }
}
