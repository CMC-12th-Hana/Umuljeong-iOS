//
//  FixMemberMyProfileView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct FixUserMyProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = FixMyProfileModel()
    @State var alertNetworkError: Bool = false //API 소통 시 필수 View
    
    init(userInfo: UserInfoResponse) {
        viewModel.nameText = userInfo.name
        viewModel.phoneText = userInfo.phoneNumber
        viewModel.staffRank = userInfo.staffRank
        viewModel.staffNumText = userInfo.staffNumber
    }

    var body: some View {
        VStack(spacing: 10){
            BasicTextFiled(label: "이름", placeHolder: "이름을 입력해주세요", inputText: $viewModel.nameText, checkRed: false)
                
            Text("\(viewModel.phoneText)")
            
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

struct FixMemberMyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FixUserMyProfileView(userInfo: UserInfoResponse(companyId: 0, memberId: 0, name: "", role: "", companyName: "", staffRank: "", phoneNumber: "", staffNumber: ""))
    }
}
