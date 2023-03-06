//
//  ExSignupView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel = SignupViewModel()
    @State var signUpButtonState = false
    @State var tapCase:TapCase?
    
    var body: some View {
        ScrollView{
            VStack(spacing: 25){
                guideText
                nameText
                VStack {
                    phoneStack
                    phoneError
                }
                
                if viewModel.appearCodeConfirm {
                    codeStack
                        .onTapGesture {
                            tapCase = .code
                        }
                }
                
                VStack(spacing:6){
                    passwordText
                    passwordGuid
                    passwordError
                }
                VStack(spacing:6){
                    confirmText
                    confirmError
                }
                
                signButton
            }
        }
        .defaultAppStyleHorizentalPadding()
        .navigationDesignDefault(title: "회원가입")
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        .popupNavigationAlertView(horizontalPadding: 40, height: 160, show: $viewModel.isTimerRunningOver) {
                TimeOverAlert(showPopup: $viewModel.isTimerRunningOver) //시간 초과 팝업
        }
        .popupNavigationAlertView(height: 175, show: $viewModel.alertPopup) {
                CodeFailAlert(showPopup: $viewModel.alertPopup) //잘못된 코드 팝업
        }
    }
    
    var guideText: some View {
        VStack(spacing:0){
            Spacer()
                .frame(height: 30)
            VStack(alignment: .leading, spacing: 6) {
                HStack{
                    Text("사용자 정보를 입력해 주세요")
                        .font(.customTitle1)
                    Spacer()
                }
                Text("입력한 이메일 및 휴대폰 번호는 로그인 아이디로 사용됩니다.")
                    .font(.body4)
            }
        }
    }
    
    var nameText: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text("이름")
                Text("*")
                    .foregroundColor(Color("error"))
            }
            .font(.special4)
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(setRoundColor(myText: viewModel.username, myCase: .name))
                
                TextField("이름을 입력해주세요", text: $viewModel.username)
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        tapCase = .name
                    }
            }
            .font(.body3)
            .frame(height: 46)
        }
    }
    
    var phoneStack: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text("휴대폰 번호")
                Text("*")
                    .foregroundColor(Color("error"))
            }
            .font(.body3)
            
            HStack(alignment: .firstTextBaseline, spacing: 7.75) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(setRoundColor(myText: viewModel.phoneNumber, myCase: .phone))
                    
                    TextField("휴대폰 번호를 입력해주세요", text: $viewModel.phoneNumber)
                        .padding(15)
                        .font(.body3)
                        .onTapGesture {
                            tapCase = .phone
                        }
                }
                .frame(height: 46)
                
                Button {
                    viewModel.requestGetCode()
                } label: {
                    Text("인증번호 받기")
                        .font(.special4)
                        .foregroundColor(viewModel.phoneButtomValid() ? Color("main") : Color("line2"))
                        .padding(13)
                        .frame(height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(viewModel.phoneButtomValid() ? Color("main") : Color("line2"), lineWidth: 1)
                        )
                }
                .disabled(!viewModel.phoneButtomValid())
            }
        }
    }
    
    var phoneError: some View {
        VStack{
            if viewModel.phoneTextFiledColorError() {
                textErrorLabel(label: "올바른 휴대폰 번호 형식이 아닙니다")
            }
        }
    }
    
    var codeStack: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            HStack(alignment: .firstTextBaseline, spacing: 7.75) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(setRoundColor(myText: viewModel.code, myCase: .code))
                    
                    
                    HStack{
                        TextField("인증번호를 입력하세요", text: $viewModel.code)
                            .font(.body3)
                            .onTapGesture {
                                tapCase = .code
                            }
                        
                        Spacer()
                        
                        Text(viewModel.timeString)
                            .font(.body4)
                            .foregroundColor(Color("error"))
                    }
                    .padding(15)
                }
                .frame(height: 46)
                
                Button {
                    viewModel.requestConfirmCode()
                } label: {
                    Text("인증번호 확인")
                        .font(.special4)
                        .foregroundColor(viewModel.confirmButtomValid() ? Color("main") : Color("line2"))
                        .padding(13)
                        .frame(height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(viewModel.confirmButtomValid() ? Color("main") : Color("line2"), lineWidth: 1)
                        )
                }
                .disabled(!viewModel.confirmButtomValid())
            }
        }
    }
    
    var passwordText: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text("비밀런호")
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
                Text("비밀번호 재입력")
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
    
    
    enum TapCase {
        case name
        case phone
        case code
        case password
        case confirmPassword
    }
    
    
    func setRoundColor(myText:String, myCase: TapCase) -> Color {
        if myCase == tapCase {
            return Color("line1")
        }
        else {
            guard !myText.isEmpty else {return Color("line2")}
            
            var myError:String? {
                switch myCase {
                case .name: return viewModel.usernameError
                case .phone: return viewModel.phoneNumberError
                case .code: return viewModel.codeError
                case .password: return viewModel.passwordError
                case .confirmPassword: return viewModel.confirmPasswordError
                }
            }
            
            if myError == nil {
                return Color("line2")
            } else {
                return Color("error")
            }
        }
    }
    
    var signButton: some View {
        Button {
            self.signUpButtonState.toggle()
//                    viewModel.signup()
        } label: {
            Spacer()
            Text("가입하기")
                .font(.body1)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(height: 50)
        .disabled(!viewModel.isSignupValid())
        .background(viewModel.isValid ? Color("main") : Color("bg1"))
        .cornerRadius(6)
        .fullScreenCover(isPresented: $signUpButtonState) {
            RoleSelectView()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


