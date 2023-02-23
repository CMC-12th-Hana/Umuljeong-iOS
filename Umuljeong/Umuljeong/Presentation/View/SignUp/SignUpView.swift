//
//  SignUpView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct SignUpView: View {
    @State var inputText: String = ""
    @State var signUpButtonState = false
    @State var onTapGesture:TapCase?
    @ObservedObject var viewModel = SignUpViewModel()
    @State var passwordClickChanged = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 26) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("사용자 정보를 입력해 주세요")
                        .font(.custom("Pretendard-Medium", size: 24))
                    Text("입력한 이메일 및 휴대폰 번호는 로그인 아이디로 사용됩니다.")
                        .font(.custom("Pretendard-Regular", size: 14))
                }.frame(width: 335)
                    .padding(30)
                
                
                SignUpBasicTextFiled(inputText: $viewModel.username, errorMessage: $viewModel.usernameError, textFiledStyle: .username, onTapGesture: onTapGesture?.usernameState)
                    .onTapGesture {
                        onTapGesture = .username
                    }
                VStack(alignment: .leading) {
                    ButtonTextFiled(inputText: $viewModel.email, errorMessage: $viewModel.emailError, textFiledStyle: .email, onTapGesture: onTapGesture?.emailState)
                        .onTapGesture {
                            onTapGesture = .email
                        }
                    Group {
                        if let emailError = viewModel.emailError  {
                            if viewModel.email != "" {
                                textErrorLabel(label: emailError)
                            }
                        }
                    }
                    .font(.custom("Pretendard-Regular", size: 14))
                }
                
                VStack(alignment: .leading) {
                ButtonTextFiled(inputText: $viewModel.phoneNumber, errorMessage: $viewModel.phoneNumberError, textFiledStyle: .phoneNumber, onTapGesture: onTapGesture?.phoneNumberState)
                    .onTapGesture {
                        onTapGesture = .phoneNumber
                    }
                
                Group {
                    if let phoneNumberError = viewModel.phoneNumberError  {
                        if viewModel.phoneNumber != "" {
                            textErrorLabel(label: phoneNumberError)
                        }
                    }

                }
                .font(.custom("Pretendard-Regular", size: 14))
            }

                
                VStack(alignment: .leading) {
                    SignUpBasicTextFiled(inputText: $viewModel.password, errorMessage: $viewModel.passwordError, textFiledStyle: .password, onTapGesture: onTapGesture?.passwordState)
                        .onTapGesture {
                            onTapGesture = .password
                        }
                        
                    Group {
                        Text("*8-20자 영문 대소문자, 숫자, 특수문자 조합")
                            .foregroundColor(Color("font2"))
                        if let passwordError = viewModel.passwordError {
                            if viewModel.password != "" {
                                textErrorLabel(label: passwordError)
                            }
                        }
                    }
                    .font(.custom("Pretendard-Regular", size: 14))
                }
                
                
                VStack(alignment: .leading) {
                    SignUpBasicTextFiled(inputText: $viewModel.confirmPassword, errorMessage: $viewModel.confirmPasswordError, textFiledStyle: .confirmPassword, onTapGesture: onTapGesture?.confirmPasswordState)
                        .onTapGesture {
                            onTapGesture = .confirmPassword
                        }
                    
                    Group {
                        if let confirmPasswordError = viewModel.confirmPasswordError  {
                            if viewModel.confirmPassword != "" {
                                textErrorLabel(label: confirmPasswordError)
                            }
                        }

                    }
                    .font(.custom("Pretendard-Regular", size: 14))
            }
                
                Button {
                    self.signUpButtonState.toggle()
                } label: {
                    Text("가입하기")
                        .font(.custom("Pretendard-Bold", size: 16))
                        .frame(width: 335, height: 50)
                        .foregroundColor(.white)
                    
                }
                .background(viewModel.isValid ? Color("main") : Color("bg1"))
                .cornerRadius(6)
                .disabled(!viewModel.isValid)
                .fullScreenCover(isPresented: $signUpButtonState) {
                    RoleSelectView()
                    
                }
            }
        }
        .navigationBarTitle("회원가입", displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}



struct textErrorLabel: View {
    let label:String
    
    var body: some View {
        HStack {
            if label != "" {
                Image("redX")
                Text(label)
                    .foregroundColor(Color("error"))
            }
        }
    }
}

