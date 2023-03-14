//
//  SignInView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State var tapCase: TapCase?
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                ImageBox(rectangleSize: 120, image: Image("Mainlogo"))
                    .padding(.bottom, 10)
                
                VStack(spacing: 8){
                    numberTextFiled
                    passwordTextFiled
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 10) {
                    Button {
                        viewModel.requestLogin()
                    } label: {
                        BasicButtonLabel(text: "로그인")
                    }
                    
                    NavigationLink {
                        PasswordView()
                    } label: {
                        // label
                        Text("비밀번호 찾기")
                            .font(.body4)
                            .underline()
                    }
                    .accentColor(Color("font2"))
                }
                .padding(.bottom, 28)
                
                NavigationLink {
                    SignupView()
                } label: {
                    HStack{
                        Spacer()
                        Text("회원가입")
                            .font(.body2)
                            .foregroundColor(Color("main"))
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("main"), lineWidth: 1.5)
                    )
                }
                
            }// : VStack
            .defaultAppStyleHorizentalPadding()
            
        } // : Navigation
        .fullScreenCover(isPresented: $viewModel.loginSuccess){
            MainTabView()
        }
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        .popupNavigationAlertView(height: 175, show: $viewModel.alertPopup) {
//            VStack {
                LoginFailAlert(showPopup: $viewModel.alertPopup)
//            }
        }
    } // : Body
    
    var numberTextFiled:some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1.0)
                .fill(tapCase == .phoneNumber ?
                      Color("line1") : Color("line2"))
            
            HStack{
                TextField("휴대폰 번호를 입력해주세요"
                          ,text: $viewModel.phoneNumber)
                .font(.body3)
                .keyboardType(.numberPad)
                .onTapGesture {
                    tapCase = .phoneNumber
                }
                
                if !viewModel.phoneNumber.isEmpty {
                    Button {
                        viewModel.removeText(tapcase: .phoneNumber)
                    } label: {
                        Image("removeText")
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        .frame(height: 46)
    }
    
    var passwordTextFiled:some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1.0)
                .fill(tapCase == .password ?
                      Color("line1") : Color("line2"))
            
            HStack{
                SecureField("비밀번호를 입력해주세요"
                          , text: $viewModel.password)
                .font(.body3)
                .textContentType(.username)
                .onTapGesture {
                    tapCase = .password
                }
                
                if !viewModel.password.isEmpty {
                    Button {
                        viewModel.removeText(tapcase: .password)
                    } label: {
                        Image("removeText")
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        .frame(height: 46)
    }


}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
