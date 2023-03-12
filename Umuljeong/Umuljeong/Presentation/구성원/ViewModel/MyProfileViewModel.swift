//
//  MyProfileViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import Foundation

class MyProfileViewModel:ObservableObject {

    let memberRepository = MemberMyDetailRepository() //내 정보 받아오기
//    let leaderRepository =
    @Published var myInfo = UserInfoResponse(companyId: 0, memberId: 0, name: "", role: "", companyName: "", staffRank: "", phoneNumber: "", staffNumber: "")

    func requestMyInfo(requestResult:@escaping (Bool) -> ()) {
        
        memberRepository.requestMyInfo { result in
            switch result {
            case .success(let myInfo):
                guard let info = myInfo else {return requestResult(false)}
                self.myInfo = info
                requestResult(true)
            case .failure(_): //상세 분류 할 것
                requestResult(false)
            }
        }
    }


}
