//
//  FixLeaderMemberProfileView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct FixMemberProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = FixMemberProfileViewModel()
    @State var alertNetworkError: Bool = false //API 소통 시 필수 View
    
    init(userInfo: UserInfoResponse) {
        viewModel.nameText = userInfo.name
        viewModel.phoneText = userInfo.phoneNumber
        viewModel.staffRank = userInfo.staffRank
        viewModel.staffNumText = userInfo.staffNumber
        viewModel.memberId = userInfo.memberId
    }

    var body: some View {
        VStack(spacing: 10){
            BasicTextFiled(label: "이름", placeHolder: "이름을 입력해주세요", inputText: $viewModel.nameText, checkRed: false)
                
            BasicTextFiled(label: "휴대폰 번호", placeHolder: "휴대폰 번호를 입력해주세요", inputText: $viewModel.phoneText, checkRed: false)
            
            BasicTextFiled(label: "직급", placeHolder: "직급을 입력해주세요", inputText: $viewModel.staffRank, checkRed: false)
            
            BasicTextFiled(label: "사번", placeHolder: "사번을 입력해주세요", inputText: $viewModel.staffNumText, checkRed: false)
            
            Spacer()
            
            Button {
                viewModel.requestProfileFix { result in
                    switch result {
                    case true: presentationMode.wrappedValue.dismiss()
                    case false: alertNetworkError = true
                    }
                }

            } label: {
                BasicButtonLabel(text: "저장")
            }
        }
        .padding(.top, 10)
        .popupNavigationAlertView(height: 160, show: $alertNetworkError) {
            FormErrorAlert(showPopup: $alertNetworkError)
        }
    }
}

struct FixLeaderMemberProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FixMemberProfileView(userInfo: UserInfoResponse(companyId: 0, memberId: 0, name: "", role: "", companyName: "", staffRank: "", phoneNumber: "", staffNumber: ""))
    }
}

