//
//  PasswordViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import Foundation
import SwiftUI
import Combine

class PasswordViewModel: ObservableObject {
    @Published var responseNewPasswordNetwork:Bool = false
    
    @Published var alertPopup:Bool = false
    @Published var phoneNumber: String = ""
    @Published var code: String = ""
    @Published var codeConfirm: Bool = false //인증코드 검증 완료 (네트워킹 결과)
    
    @Published var appearCodeConfirm:Bool = false
    @Published var getCodeNetworkResult:Bool = true
    
    @Published var timeString: String = "03:00"
    @Published var isTimerRunningOver: Bool = false
    
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var passwordError:Bool = true
    @Published var confirmPasswordError:Bool = true
    
    @Published var passwordError1:Bool = false
    @Published var passwordError2:Bool = false
    @Published var passwordError3:Bool = false
    @Published var passwordError4:Bool = false
    
    private var timer: AnyCancellable?
    private var startTime: Date?
    
    private var cancellableSet: Set<AnyCancellable> = [] //❓ 해제 시 삭제 : 확인하기

    //적절한 번호가 들어오면 getCodeButtonState == true
    var isValid:Bool = false
    
    init() {
        
        Publishers.CombineLatest(self.passwordValidatorPublisher, self.confirmPasswordValidatorPublisher)
            .dropFirst()
            .sink { _passwordValidator, _confirmPasswordError in
                self.isValid = _passwordValidator == false &&
                _confirmPasswordError == false
            }
            .store(in: &cancellableSet)
        
        passwordValidatorPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
            self.passwordError = _passwordValidator
            }
            .store(in: &cancellableSet)

        confirmPasswordValidatorPublisher
                .dropFirst()
                   .sink { (_passwordValidator) in
                   self.confirmPasswordError = _passwordValidator
                   }
                   .store(in: &cancellableSet)
    }
    
    private var passwordValidatorPublisher: AnyPublisher<Bool, Never> {
        $password
            .removeDuplicates()
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { password in
                if password != self.confirmPassword {
                    self.confirmPasswordError = true
                }
                //함수 만들어서 풀기
                if !self.passwordValidCheck(password: password) {
                    return true
                } else {
                    return false
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidatorPublisher: AnyPublisher<Bool, Never> {
        $confirmPassword
            .debounce(for: 0.0, scheduler: RunLoop.main)
            .map { confirmPassword in
                if confirmPassword != self.password {
                    return true
                } else if confirmPassword.isEmpty {
                    return true
                }
                else {
                    return false
                }
            }
        .eraseToAnyPublisher()
    }
    
    
    func requestNewPassword() {
        responseNewPasswordNetwork = true //임시 입력값 //네트워킹 요청 결과값
    }

    func phoneTextFiledColorError() -> Bool {
        return !phoneNumber.isValidPhoneNumber && !phoneNumber.isEmpty
    }
    
    func phoneButtomValid() -> Bool {
        return phoneNumber.isValidPhoneNumber
    }
    
    func confirmButtomValid() -> Bool {
        return phoneButtomValid() && getCodeNetworkResult && code.isValidCode
    }
    
    func requestGetCode() {
        appearCodeConfirm = true
        //누르자마자 타이머 실행
        startTimer()
    }
    
    func requestConfirmCode() {
        let confirmCodeResult = true //임의값
        if confirmCodeResult == true {
            finishTimer() //타이머 멈추기
            codeConfirm = true //화면 넘어가기
        } else {
            alertPopup = true //잘못된 인증번호입니다
        }
    }
    
    private func startTimer() {
            timeString = "02:59"
            isTimerRunningOver = false
            startTime = Date()
            timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.updateTimeString()
                }
        }
    
    private func finishTimer() {
        timer?.cancel()
    }
        
    private func updateTimeString() {
        guard let startTime = startTime else {
            timeString = "03:00"
            return
        }
        
        let elapsedTime = Date().timeIntervalSince(startTime)
        let remainingTime = 3 * 60 - elapsedTime
        guard remainingTime > 0 else {
            timeString = "00:00"
            timer?.cancel()
            appearCodeConfirm = false
            isTimerRunningOver = true
            // Add your event notifying code here.
            return
        }
        
        let minutes = Int(remainingTime / 60)
        let seconds = Int(remainingTime) % 60
        
        let minuteString = String(format: "%02d", minutes)
        let secondString = String(format: "%02d", seconds)
        
        timeString = "\(minuteString):\(secondString)"
    }
    
    
    
    
    
    func checkRoundFillConfirmError() -> Bool {
        return !confirmPassword.isEmpty && confirmPasswordError == true
    }
    
    func checkRoundFillPhoneError() -> Bool {
        return !phoneNumber.isEmpty && passwordError == true
    }
    
    
    
    func passwordValidCheck(password:String) -> Bool {
        if !password.passwordEight {
            passwordError1 = true
        } else {
            passwordError1 = false
        }
        
        if !password.passwordLargeSmallEng {
            passwordError2 = true
        } else {
            passwordError2 = false
        }
        
        if !password.passwordContainInt {
            passwordError3 = true
        } else {
            passwordError3 = false
        }
        
        if !password.passwordContainSpecial {
            passwordError4 = true
        } else {
            passwordError4 = false
        }
        
        if password.passwordEight && password.passwordLargeSmallEng && password.passwordContainInt && password.passwordContainSpecial {
            return true
        } else {
            return false
        }
    }
    
    
}


