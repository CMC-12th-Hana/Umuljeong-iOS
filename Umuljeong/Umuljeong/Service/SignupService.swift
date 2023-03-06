//
//  SignupServiceImpl.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/03.


import Foundation

class SignupService {
    let repository = SignupRepositoryImpl()
    
    func requestSignup(signupInfo: SignupInfo, completion: @escaping (NetworkResult<Any>) -> Void) {
        repository.requestSignup(signupInfo: signupInfo) { response in
            switch response {
            case .success(let data):
                completion(response)
                
                guard let data = data as? SignupResponse else { return }
                self.setAccessToken(token: data.accessToken ?? "")
                
            default : completion(response)
            }
        }
    }
        
    func setAccessToken(token: String) {
        print("저장해야 할 토큰 정보 처리하기: \(token)")
    }
}
