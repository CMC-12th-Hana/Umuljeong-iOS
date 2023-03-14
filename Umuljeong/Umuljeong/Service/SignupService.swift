//
//  SignupServiceImpl.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/03.


import Foundation

class SignupService {
    let signupRepository = SignupRepositoryImpl()
    let myUniqueInfoRepository = MemberUniqueInfoRepository()
    
    func requestSignup(signupInfo: SignupInfo, completion: @escaping (NetworkResult<Any>) -> Void) {
        signupRepository.requestSignup(signupInfo: signupInfo) { response in
            switch response {
            case .success:
                print("회원가입 성공!! ")
                self.requestUniqueUserInfo {
                    completion(response)
                }
                
            default : completion(response)
            }
        }
    }
    
    func requestUniqueUserInfo(completion: @escaping () -> ()) {
        myUniqueInfoRepository.requestMyUniqueInfo { result in
            print("회원 정보 가져와서 저장")
            switch result {
            case .success(_): completion()
            case .failure(_): completion()
            }
        }
    }
        
    func setAccessToken(token: String) {
        print("저장해야 할 토큰 정보 처리하기: \(token)")
    }
}
