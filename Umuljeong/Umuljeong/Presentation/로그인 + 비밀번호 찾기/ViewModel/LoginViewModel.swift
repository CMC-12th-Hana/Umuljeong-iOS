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
    let repository = LoginRepository()
    
    func removeText(tapcase: TapCase) {
        if tapcase == .phoneNumber {
            phoneNumber = ""
        } else {
            password = ""
        }
    }
    
    func requestLogin() {
        repository.requestLogin(loginInfo: LoginInfo(phoneNumber: phoneNumber, password: password)) { result in
            switch result {
            case true: self.loginSuccess = true
            case false: self.alertPopup = true
            }
        }
    }
}
