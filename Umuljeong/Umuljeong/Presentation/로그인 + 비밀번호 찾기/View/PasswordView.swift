//
//  PasswordView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import SwiftUI

struct PasswordView: View {
    @ObservedObject var viewModel = PasswordViewModel()
    @State var tapCase: passwordViewTapCase?
    
    var body: some View {
        VStack(spacing: 30){
            Spacer()
                .frame(height: 30)
            guildText
            VStack(spacing: 6){
                ButtonTextField
                phoneError
            }
            
            if viewModel.appearCodeConfirm {
                CodeTextField
                    .onTapGesture {
                        tapCase = .code
                    }
            }
            
            NavigationLink(destination: NewPasswordView(), isActive: $viewModel.codeConfirm) { //명령어로 이동하는 네비게이션
                EmptyView()
            }
            Spacer()
        }
        .defaultAppStyleHorizentalPadding()
        .onAppear(perform : UIApplication.shared.hideKeyboard) //외부 터치에 키보드 반응
        .navigationDesignDefault(title: "비밀번호 찾기")
        .popupNavigationAlertView(horizontalPadding: 40, height: 160, show: $viewModel.isTimerRunningOver) {
                TimeOverAlert(showPopup: $viewModel.isTimerRunningOver) //시간 초과 팝업
        }
        .popupNavigationAlertView(height: 175, show: $viewModel.alertPopup) {
                CodeFailAlert(showPopup: $viewModel.alertPopup) //잘못된 코드 팝업
        }
    }
    
    var guildText:some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack{
                Text("비밀번호를 잊으셨나요?")
                    .font(.customTitle1)
                Spacer()
            }
            Text("비밀번호 재설정을 위해 휴대폰 번호를 입력해주세요.")
                .font(.body4)
        }
    }
    
    var ButtonTextField: some View {
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
                        .fill(tapCase == .phoneNumber ? Color("line1") : Color("line2"))
                        
                    TextField("휴대폰 번호를 입력해주세요", text: $viewModel.phoneNumber)
                        .padding(15)
                        .font(.body3)
                        .onTapGesture {
                            tapCase = .phoneNumber
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
    
    var CodeTextField: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            HStack(alignment: .firstTextBaseline, spacing: 7.75) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(tapCase == .code ? Color("line1") : Color("line2"))
                        
                    
                    HStack{
                        TextField("인증번호를 입력하세요", text: $viewModel.code)
                            
                            .font(.body3)
                        
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
    
    enum passwordViewTapCase {
        case phoneNumber
        case reciveCode
        case code
        case confirmCode
    }
    
//        }
//
//            VStack(alignment: .leading) {
//                ButtonTextFiled(inputText: $viewModel.phoneNumber, errorMessage: $viewModel.phoneNumberError, textFiledStyle: .phoneNumber, onTapGesture: onTapGesture?.phoneNumberState)
//                    .keyboardType(.numberPad)
//                    .onTapGesture {
//                        onTapGesture = .phoneNumber
//                    }
//
//
//
//            }
//        }
//        .navigationDesignDefault(title: "비밀번호 찾기")
//    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
