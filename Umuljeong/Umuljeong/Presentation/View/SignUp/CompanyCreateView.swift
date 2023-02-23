//
//  CompanyCreateView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct CompanyCreateView: View {
    @ObservedObject var viewModel = CompanyCreateViewModel()
    @State var signUpButtonState = false
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(alignment: .firstTextBaseline) {
                Text("회사 정보를 입력해주세요.")
                    .font(.custom("Pretendard-Medium", size: 24))
                Spacer()
            }.frame(width: 335)
                .padding(.top, 30)
            
            BasicTextFiled(label: "회사명", placeHolder: "회사명을 입력해주세요", inputText: $viewModel.company)
            BasicTextFiled(label: "담당자명", placeHolder: "담당자명을 입력해주세요", inputText: $viewModel.manager)
            
            Spacer()
            
            Button {
                self.signUpButtonState.toggle()
            } label: {
                Text("확인")
                    .font(.custom("Pretendard-Bold", size: 16))
                    .frame(width: 335, height: 50)
                    .foregroundColor(.white)
            }
            .background(viewModel.isValid ? Color("main") : Color("bg1"))
            .cornerRadius(6)
            .disabled(!viewModel.isValid)
            .fullScreenCover(isPresented: $signUpButtonState) {
                MainTabView()
            }
        }
        .navigationBarTitle("새 회사 만들기", displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
    }
}

struct CompanyCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCreateView()
    }
}
