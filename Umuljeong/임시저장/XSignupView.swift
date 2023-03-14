//
//  SignUpView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

//import SwiftUI
//
//struct SignupView: View {
//    @State var inputText: String = ""
//    @State var signUpButtonState = false
//    @State var tapCase:TapCase?
//    @ObservedObject var viewModel = SignupViewModelImpl()
//    @State var passwordClickChanged = false
//
//    var body: some View {
//        VStack(spacing: 26) {
//            Spacer()
//                .frame(height: 30)
//
//            VStack(alignment: .leading, spacing: 6) {
//                HStack{
//                    Text("사용자 정보를 입력해 주세요")
//                        .font(.customTitle1)
//                    Spacer()
//                }
//                    Text("입력한 이메일 및 휴대폰 번호는 로그인 아이디로 사용됩니다.")
//                        .font(.body4)
//            }
//
//            SignUpBasicTextFiled(inputText: $viewModel.username, errorMessage: $viewModel.usernameError, textFiledStyle: .username, onTapGesture: tapCase?.usernameState)
//                .onTapGesture {
//                    tapCase = .username
//                }
//
//            VStack(alignment: .leading) {
//            ButtonTextFiled(inputText: $viewModel.phoneNumber, errorMessage: $viewModel.phoneNumberError, textFiledStyle: .phoneNumber, onTapGesture: tapCase?.phoneNumberState)
//                .keyboardType(.numberPad)
//                .onTapGesture {
//                    tapCase = .phoneNumber
//                }
//
//            Group {
//                if let phoneNumberError = viewModel.phoneNumberError  {
//                    if viewModel.phoneNumber != "" {
//                        textErrorLabel(label: phoneNumberError)
//                    }
//                }
//
//            }
//            .font(.custom("Pretendard-Regular", size: 14))
//        }
//
//
//            VStack(alignment: .leading) {
//                SignUpBasicTextFiled(inputText: $viewModel.password, errorMessage: $viewModel.passwordError, textFiledStyle: .password, onTapGesture: tapCase?.passwordState)
//                    .onTapGesture {
//                        tapCase = .password
//                    }
//
//                Group {
//                    Text("*8-20자 영문 대소문자, 숫자, 특수문자 조합")
//                        .foregroundColor(Color("font2"))
//                    if let passwordError = viewModel.passwordError {
//                        if viewModel.password != "" {
//                            textErrorLabel(label: passwordError)
//                        }
//                    }
//                }
//                .font(.custom("Pretendard-Regular", size: 14))
//            }
//
//
//            VStack(alignment: .leading) {
//                SignUpBasicTextFiled(inputText: $viewModel.confirmPassword, errorMessage: $viewModel.confirmPasswordError, textFiledStyle: .confirmPassword, onTapGesture: tapCase?.confirmPasswordState)
//                    .onTapGesture {
//                        tapCase = .confirmPassword
//                    }
//
//                Group {
//                    if let confirmPasswordError = viewModel.confirmPasswordError  {
//                        if viewModel.confirmPassword != "" {
//                            textErrorLabel(label: confirmPasswordError)
//                        }
//                    }
//
//                }
//                .font(.body3)
//        }
//
//            Spacer()
//
//            Button {
//                self.signUpButtonState.toggle()
////                    viewModel.signup()
//            } label: {
//                Spacer()
//                Text("가입하기")
//                    .font(.body1)
//                    .foregroundColor(.white)
//                Spacer()
//            }
//            .frame(height: 50)
//            .disabled(!viewModel.isValid)
//            .background(viewModel.isValid ? Color("main") : Color("bg1"))
//            .cornerRadius(6)
//            .fullScreenCover(isPresented: $signUpButtonState) {
//                RoleSelectView()
//            }
//        }
//        .navigationDesignDefault(title: "회원가입")
//        .defaultAppStyleHorizentalPadding()
////        .onAppear{
////            viewModel.signup()
////        }
//        .onAppear(perform : UIApplication.shared.hideKeyboard)
//    }
//
//    var CodeTextField: some View {
//        VStack(alignment: .leading, spacing: 6) {
//
//            HStack(alignment: .firstTextBaseline, spacing: 7.75) {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 6)
//                        .stroke(lineWidth: 1.0)
//                        .fill(tapCase == .code ? Color("line1") : Color("line2"))
//
//
//                    HStack{
//                        TextField("인증번호를 입력하세요", text: $viewModel.phoneNumber)
//
//                            .font(.body3)
//
//                        Spacer()
//
////                        Text(viewModel.timeString)
////                            .font(.body4)
////                            .foregroundColor(Color("error"))
//                    }
//                    .padding(15)
//                }
//                .frame(height: 46)
//
//                Button {
//                    print("")
//                } label: {
//                    Text("인증번호 확인")
//                        .font(.special4)
//                        .foregroundColor(Color("line2"))
//                        .padding(13)
//                        .frame(height: 46)
//                        .background(
//                            RoundedRectangle(cornerRadius: 6)
//                                .stroke(Color("line2"), lineWidth: 1)
//                        )
//                }
//            }
//        }
//    }
//}
//
//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
//

