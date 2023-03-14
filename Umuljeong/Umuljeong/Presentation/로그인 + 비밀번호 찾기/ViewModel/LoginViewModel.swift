//
//  LoginViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginSuccess:Bool = false
    @Published var alertPopup:Bool = false
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    
    let loginRepository = LoginRepository()
    let myUniqueInfoRepository = MemberUniqueInfoRepository()
    
    
    func removeText(tapcase: TapCase) {
        if tapcase == .phoneNumber {
            phoneNumber = ""
        } else {
            password = ""
        }
    }
    
    func requestLogin() {
        loginRepository.requestLogin(loginInfo: LoginInfo(phoneNumber: phoneNumber, password: password)) { result in
            switch result {
            case true:
                self.requestUniqueUserInfo()
            case false: self.alertPopup = true
            }
        }
    }
    
    func requestUniqueUserInfo() {
        myUniqueInfoRepository.requestMyUniqueInfo { result in
            print("회원 정보 가져와서 저장")
            switch result {
            case .success(_):
                self.loginSuccess = true
                print("회원정보 저장 완료")
            case .failure(_): print("회원정보 저장 실패")
            }
        }
    }
    
    
}
