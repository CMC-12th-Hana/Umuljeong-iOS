//
//  SignupViewModelImpl.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/07.
//

import Foundation
import SwiftUI
import Combine

class SignupViewModelImpl: ObservableObject {
    let service = SignupServiceImpl()
    
    //받아온 값 (공유)
    @Published var username: String = ""
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    //버튼 상태
    var basicValid:Bool = false
    
    @Published var isValid: Bool = false
    
//    @Published var passwordValidator = PasswordValidation.eightCount
    
    //각 상태에 따른 String 출력
    @Published var usernameError: String? = Optional("")
    @Published var phoneNumberError: String? = Optional("")
    @Published var passwordError: String? = Optional("")
    @Published var confirmPasswordError: String? = Optional("")
    
    private var cancellableSet: Set<AnyCancellable> = [] //❓ 해제 시 삭제 : 확인하기

    
    init() { //발행자 생성 //비번은 컨펌으로 확인
//
//        Publishers.CombineLatest(self.validUserNamePublisher)
//            .dropFirst()
//            .sink { _usernameError in
//                self.basicValid = _usernameError == nil
//            }
//            .store(in: &cancellableSet)
//
//
//
//

        Publishers.CombineLatest4(self.validUserNamePublisher, self.validPhoneNumberPublisher, self.passwordValidatorPublisher, self.confirmPasswordValidatorPublisher)
            .dropFirst()
            .sink { _usernameError, _phoneNumberError, _passwordValidator, _confirmPasswordValidator  in
                self.isValid = self.basicValid &&
                        _usernameError == nil &&
                        _phoneNumberError == nil &&
                        _passwordValidator.errorMessage == nil &&
                        _confirmPasswordValidator.confirmPasswordErrorMessage == nil
        }
        .store(in: &cancellableSet)

        validUserNamePublisher
            .dropFirst()
            .sink { (_username) in
                self.usernameError = _username
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
    
    // MARK: - 강제 입력 형태
    /**SignupViewModel의 회원가입 요청 메서드*/
    func signup() {
        service.requestSignup(signupInfo: SignupInfo(name: "가나다", phoneNumber: "01011111111", password: "qweR!1234", passwordCheck: "qweR!1234")) { response in
            switch response {
            case .success:
                print("SignupViewModel : 회원가입 성공")
            default : print("SignupViewModel : 통신 실패")
            }
        }
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


