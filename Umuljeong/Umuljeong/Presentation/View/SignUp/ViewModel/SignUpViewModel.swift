//
//  SignUpViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/07.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    //받아온 값 (공유)
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    //버튼 상태
    var basicValid:Bool = false
    
    @Published var isValid: Bool = false
    
//    @Published var passwordValidator = PasswordValidation.eightCount
    
    //각 상태에 따른 String 출력
    @Published var usernameError: String? = Optional("")
    @Published var emailError: String? = Optional("")
    @Published var phoneNumberError: String? = Optional("")
    @Published var passwordError: String? = Optional("")
    @Published var confirmPasswordError: String? = Optional("")
    
    private var cancellableSet: Set<AnyCancellable> = [] //❓ 해제 시 삭제 : 확인하기

    
    init() { //발행자 생성 //비번은 컨펌으로 확인
        
        Publishers.CombineLatest(self.validUserNamePublisher, self.validEmailPublisher)
            .dropFirst()
            .sink { _usernameError, _emailError in
                self.basicValid = _usernameError == nil &&
                    _emailError == nil
            }
            .store(in: &cancellableSet)
        
        
        validUserNamePublisher
            .dropFirst()
            .sink { (_username) in
                self.usernameError = _username
            }
            .store(in: &cancellableSet)
        
        validEmailPublisher
            .dropFirst()
            .sink { (_email) in
                self.emailError = _email
            }
            .store(in: &cancellableSet)

        

        Publishers.CombineLatest3(self.validPhoneNumberPublisher, self.passwordValidatorPublisher, self.confirmPasswordValidatorPublisher)
            .dropFirst()
            .sink { _phoneNumberError, _passwordValidator, _confirmPasswordValidator  in
                self.isValid = self.basicValid &&
                        _phoneNumberError == nil &&
                        _passwordValidator.errorMessage == nil &&
                        _confirmPasswordValidator.confirmPasswordErrorMessage == nil
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
                   self.confirmPasswordError = _passwordValidator.confirmPasswordErrorMessage
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
    
    
    private var validEmailPublisher: AnyPublisher<String?, Never> {
        $email
            .debounce(for: 0, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _email in
                if !_email.isValidEmail {
                    return "올바른 이메일 형식이 아닙니다"
                } else {
                    return nil
                }
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
                if !password.passwordEight {
                    return .eightCount
                } else if !password.passwordLargeSmallEng {
                    return .largeSmallEng
                } else if !password.passwordContainInt {
                    return .containInt
                } else if !password.passwordContainSpecial {
                    return .containSpecial
                }
                else {
                    return .pass
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidatorPublisher: AnyPublisher<PasswordValidation, Never> {
        $confirmPassword
            .debounce(for: 0.0, scheduler: RunLoop.main)
            .map { confirmPassword in
                if self.password != confirmPassword {
                    return .notMatch
                } else {
                    return .pass
                }
            }
        .eraseToAnyPublisher()
    }
}


extension String {
    
    var passwordEight: Bool {
        let phoneNumberRegEx = "^.{8,20}$"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var passwordLargeSmallEng: Bool {
        let phoneNumberRegEx = "^(?=.*[a-z])(?=.*[A-Z]).+"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var passwordContainInt: Bool {
        let phoneNumberRegEx = "^(?=.*[0-9]).+"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var passwordContainSpecial: Bool {
        let phoneNumberRegEx = "^(?=.*[-+_!@#$%^&*., ?]).+"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    
    var isValidUsername: Bool {
        return self.count > 1
    }
    
    var isValidPhoneNumber: Bool {
        let phoneNumberRegEx = "^01[0-1, 7][0-9]{7,8}$"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}











public enum PasswordValidation {
    case eightCount
    case largeSmallEng
    case containInt
    case containSpecial
    case notMatch
    case error
    case pass
    
    var errorMessage: String? {
        switch self {
        case .eightCount:
            return "8자 이상 입력해주세요"
        case .largeSmallEng:
            return "영문 대소문자를 포함해주세요"
        case .containInt:
            return "숫자를 포함해주세요"
        case .containSpecial:
            return "특수문자를 포함해주세요"
        case .error:
            return "조건 통과 실패"
         default:
            return nil
        }
    }
    
    var confirmPasswordErrorMessage: String? {
        switch self {
        case .notMatch:
            return "비밀번호와 일치하게 입력해주세요"
        case .error:
            return "조건 통과 실패"
         default:
            return nil
        }
    }
}


