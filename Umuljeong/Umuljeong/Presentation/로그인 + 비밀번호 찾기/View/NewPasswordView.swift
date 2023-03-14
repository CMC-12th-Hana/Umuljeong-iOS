//
//  NewPasswordView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import SwiftUI

struct NewPasswordView: View {
    @ObservedObject var viewModel = PasswordViewModel()
    @State var tapCase: newPasswordTapCase?
    @State var returnLoginView:Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
                .frame(height: 30)
            VStack(spacing: 20) {
                VStack(spacing:6){
                    passwordText
                    passwordGuid
                    passwordError
                }
                
                VStack(spacing: 6){
                    confirmText
                    confirmError
                }
            }
            Spacer()
            completeButton
                .padding(.bottom, 50)
        }
        .navigationDesignDefault(title: "비밀번호 찾기")
        .navigationBarBackButtonHidden()
        .defaultAppStyleHorizentalPadding()
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        .popupNavigationAlertView(horizontalPadding: 40, height: 140, show: $viewModel.responseNewPasswordNetwork) {
            CompleteNewPasswordAlert(showPopup: $viewModel.responseNewPasswordNetwork, returnLoginView: $returnLoginView)
        }
        .fullScreenCover(isPresented: $returnLoginView) {
            LoginView()
        }
    }
    
    var passwordText: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text("새 비밀번호 등록")
                Text("*")
                    .foregroundColor(Color("error"))
            }
            .font(.special4)
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(setRoundColor(myText: viewModel.password, myCase: .password))
                
                
                SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                    .padding(.horizontal, 15)
                    .textContentType(.username)
                    .onTapGesture {
                        tapCase = .password
                    }
            }
            .font(.body3)
            .frame(height: 46)
        }
    }
    
    var passwordGuid: some View {
        HStack{
            Text("*8-20자 영문 대소문자, 숫자, 특수문자 조합")
                .foregroundColor(Color("font2"))
                .font(.body5)
            
            Spacer()
        }
    }
    
    var passwordError: some View {
        VStack{
            if !viewModel.password.isEmpty {
                if viewModel.passwordError1 {
                    textErrorLabel(label: "8자 이상 20자 이하로 입력해주세요")
                }
                if viewModel.passwordError2 {
                    textErrorLabel(label: "영문 대소문자를 포함해주세요")
                }
                if viewModel.passwordError3 {
                    textErrorLabel(label: "숫자를 포함해주세요")
                }
                if viewModel.passwordError4 {
                    textErrorLabel(label: "특수문자를 포함해주세요")
                }
            }
        }
    }
    
    var confirmText: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text("새 비밀번호 확인")
                Text("*")
                    .foregroundColor(Color("error"))
            }
            .font(.special4)
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(setRoundColor(myText: viewModel.confirmPassword, myCase: .confirmPassword))
                
                SecureField("비밀번호를 재입력해주세요", text: $viewModel.confirmPassword)
                    .padding(.horizontal, 15)
                    .textContentType(.username)
                    .onTapGesture {
                        tapCase = .confirmPassword
                    }
            }
            .font(.body3)
            .frame(height: 46)
        }
    }
    
    var confirmError: some View {
        VStack{
            if viewModel.checkRoundFillConfirmError() {
                textErrorLabel(label: "비밀번호와 일치하게 입력해주세요")
            }
        }
    }
    
    var completeButton: some View {
        Button {
            viewModel.requestNewPassword()
        } label: {
            Spacer()
            Text("완료")
                .font(.body1)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(height: 50)
        .disabled(!viewModel.isValid)
        .background(viewModel.isValid ? Color("main") : Color("bg1"))
        .cornerRadius(6)
    }
    
    enum newPasswordTapCase {
        case password
        case confirmPassword
    }
    
    func setRoundColor(myText:String, myCase: newPasswordTapCase) -> Color {
        if myCase == tapCase {
            return Color("line1")
        }
        else {
            guard !myText.isEmpty else {return Color("line2")}
            
            var myError:Bool {
                switch myCase {
                case .password: return viewModel.passwordError
                case .confirmPassword: return viewModel.confirmPasswordError
                }
            }
            
            if myError == false {
                return Color("line2")
            } else {
                return Color("error")
            }
        }
    }
    
    
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
