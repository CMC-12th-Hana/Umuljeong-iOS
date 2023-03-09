//
//  AddMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/09.
//

import SwiftUI

struct AddMemberView: View {
    @ObservedObject var viewModel = AddMemberViewModel()
    
    var body: some View {
        VStack(spacing: 25) {
            ScrollView {
                BasicTextFiled(label: "사원 이름", placeHolder: "사원 이름을 입력해주세요", inputText: $viewModel.name)
                BasicTextFiled(label: "기업 대표 전화", placeHolder: "휴대폰 번호를 입력해주세요", inputText: $viewModel.phoneNumber)
                BasicTextFiled(label: "직급", placeHolder: "직급을 입력해주세요", inputText: $viewModel.staffRank, checkRed: false)
                BasicTextFiled(label: "사번", placeHolder: "사번을 입력해주세요", inputText: $viewModel.staffNumber, checkRed: false)
            }
            .padding(.top, 30)
            
            Spacer()
            
            Button {
                
            } label: {
                BasicButtonLabel(text: "완료")
            }
        }
        .navigationDesignDefault(title: "구성원 추가하기")
        .defaultAppStyleHorizentalPadding()
    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
