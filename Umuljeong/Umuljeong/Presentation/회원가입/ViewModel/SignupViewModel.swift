//
//  SignupViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    let service = SignupService()
    
    //코드 인증 관련 
    @Published var alertPopup:Bool = false
    @Published var isTimerRunningOver: Bool = false
    @Published var timeString: String = "03:00"
    @Published var appearCodeConfirm:Bool = false //코드 요청 버튼 누름
    @Published var getCodeNetworkResult:Bool = true //요청 네트워킹 성공
    
    @Published var signUpButtonState:Bool = false //회원 가입 완료 후 화면 이동
    
    private var timer: AnyCancellable?
    private var startTime: Date?
    
    @Published var username: String = ""
    @Published var phoneNumber: String = ""
    @Published var code: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    //각 상태에 따른 String 출력
    @Published var usernameError: String? = " "
    @Published var phoneNumberError: String? = " "
    @Published var codeError: String? = " "
    @Published var passwordError: String? = " "
    @Published var confirmPasswordError: String? = " "
    
    @Published var passwordError1:Bool = false
    @Published var passwordError2:Bool = false
    @Published var passwordError3:Bool = false
    @Published var passwordError4:Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = [] //❓ 해제 시 삭제 : 확인하기
    
    //버튼 상태
    var basicValid:Bool = false
    var codeConfirm: Bool = false //인증코드 검증 완료 (네트워킹 결과)
    
    @Published var isValid: Bool = false
    
    func requestSignup() {
        service.requestSignup(signupInfo: SignupInfo(name: self.username, phoneNumber: self.phoneNumber, password: self.password, passwordCheck: self.confirmPassword)) { result in
            switch result {
            case .success(_): self.signUpButtonState = true; print("회원가입 완료 됐다 : 여기 ViewModel 임"); break
                
            case .requestError: break
                
            case .pathError: break
                
            case .serverError: break
                
            case .networkFail: break
                
            }
        }
    }
    
    init() {
        
        Publishers.CombineLatest(self.validUserNamePublisher, self.validCodePublisher)
            .dropFirst()
            .sink { _usernameError, _codeError in
                self.basicValid = _usernameError == nil &&
                                    _codeError == nil //코드 에러 안씀. 추후 삭제
            }
            .store(in: &cancellableSet)

        Publishers.CombineLatest3(self.validPhoneNumberPublisher, self.passwordValidatorPublisher, self.confirmPasswordValidatorPublisher)
            .dropFirst()
            .sink {_phoneNumberError, _passwordValidator, _confirmPasswordError  in
                self.isValid = self.basicValid &&
                        _phoneNumberError == nil &&
                        _passwordValidator.errorMessage == nil &&
                        _confirmPasswordError == nil
        }
        .store(in: &cancellableSet)

        validUserNamePublisher
            .dropFirst()
            .sink { (_username) in
                self.usernameError = _username
            }
            .store(in: &cancellableSet)
        
        validCodePublisher
            .dropFirst()
            .sink { (_code) in
                self.codeError = _code
            }
            .store(in: &cancellableSet)
        
        validPhoneNumberPublisher
            .dropFirst()
            .sink { (_phoneNumber) in
                self.phoneNumberError = _phoneNumber
            }
            .store(in: &cancellableSet)
        
        passwordValidatorPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
            self.passwordError = _passwordValidator.errorMessage
            }
            .store(in: &cancellableSet)

        confirmPasswordValidatorPublisher
                .dropFirst()
                   .sink { (_passwordValidator) in
                   self.confirmPasswordError = _passwordValidator
                   }
                   .store(in: &cancellableSet)
    }
    
    private var validUserNamePublisher: AnyPublisher<String?, Never> {
        $username
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _username in
                if _username.isEmpty {
                    return "이름을 입력해주세요"
                } else if !_username.isValidUsername {
                    return "양식에 맞는 이름을 입력해 주세요"
                } else {
                    return nil
                }
        }
        .eraseToAnyPublisher()
    }
    
    func isSignupValid() -> Bool {
        return isValid && codeConfirm
    }
    
    private var validCodePublisher: AnyPublisher<String?, Never> {
        $code
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _code in
                    return nil
        }
        .eraseToAnyPublisher()
    }
    
    private var validPhoneNumberPublisher: AnyPublisher<String?, Never> {
        $phoneNumber
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _phoneNumber in
                if !_phoneNumber.isValidPhoneNumber {
                    return "양식에 맞는 번호를 입력해주세요"
                } else {
                    return nil
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var passwordValidatorPublisher: AnyPublisher<PasswordValidation, Never> {
        $password
            .removeDuplicates()
            .debounce(for: 0, scheduler: RunLoop.main)
            .map { password in
                if password != self.confirmPassword {
                    self.confirmPasswordError = "비밀번호와 일치하게 입력해주세요"
                }
                //함수 만들어서 풀기
                if !self.passwordValidCheck(password: password) {
                    return .eightCount
                } else {
                    return .pass
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidatorPublisher: AnyPublisher<String?, Never> {
        $confirmPassword
            .debounce(for: 0.0, scheduler: RunLoop.main)
            .map { confirmPassword in
                if confirmPassword != self.password {
                    return "비밀번호와 일치하게 입력해주세요"
                } else if confirmPassword.isEmpty {
                    return "아무 것도 없음"
                }
                else {
                    return nil
                }
            }
        .eraseToAnyPublisher()
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
    
    func checkRoundFillConfirmError() -> Bool {
        return !confirmPassword.isEmpty && confirmPasswordError != nil
    }
    
    func checkRoundFillPhoneError() -> Bool {
        return !phoneNumber.isEmpty && phoneNumberError != nil
    }
    
}



//인증번호 관련

extension SignupViewModel {
    
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
            codeConfirm = true //인증 완료
            print(codeConfirm)
            print(self.basicValid)
            print(self.isValid)
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
}
