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
                    .font(.customTitle1)
                Spacer()
            }
            .padding(.top, 32)
            
            VStack(spacing: 25){
                VStack(spacing: 8){
                    BasicTextFiled(label: "그룹 이름", placeHolder: "그룹이름을 입력해주세요", inputText: $viewModel.company)
                    HStack{
                        Text("*개인으로 사용할 시 임의로 그룹명을 입력해주세요")
                            .font(.body5)
                            .foregroundColor(Color("font2"))
                        Spacer()
                    }
                }
                BasicTextFiled(label: "사용자 이름", placeHolder: "담당자명을 입력해주세요", inputText: $viewModel.manager)
            }
            
            Spacer()
            
            Button {
                viewModel.requestCreateCompany()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .fill(viewModel.isValid ? Color("main") : Color("bg1"))
                        .frame(height: 50)
                        
                    Text("확인")
                        .font(.body1)
                        .foregroundColor(.white)
                }
            }
            .disabled(!viewModel.isValid)
            .fullScreenCover(isPresented: $viewModel.moveMainTab) {
                MainTabView()
            }
        }
        .navigationDesignDefault(title: "시작하기")
        .defaultAppStyleHorizentalPadding()
    }
}

struct CompanyCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCreateView()
    }
}
