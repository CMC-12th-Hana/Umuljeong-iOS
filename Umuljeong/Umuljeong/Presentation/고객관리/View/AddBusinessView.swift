//
//  AddBusinessView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct AddBusinessView: View {
    @ObservedObject var viewModel = AddBusinessViewModel()
    
    @State var 사업이름: String = ""
    @State var 매출액: String = ""
    var body: some View {
        VStack(spacing:20){
            BasicTextFiled(label: "사업 이름", placeHolder: "사업 이름을 입력해주세요", inputText: $사업이름)
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing:0){
                    Text("예상 사업기간")
                    Text("*")
                        .foregroundColor(Color("error"))
                }
                .font(.body4)
                StartFinishDateView(showStartCalendar: $viewModel.showStartCalendar, showFinishCalendar: $viewModel.showFinishCalendar, startDateString: viewModel.startDateString, finishDateString: viewModel.finishDateString)
            }
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing:0){
                    Text("참여 구성원 추가")
                }
                .font(.body4)
                
                NavigationLink {
                    EmployeeProfileView()
                        .navigationTitleFontDefault(title: "사원 프로필")
                } label: {
                    ImportEmployeeLabel()
                }
            }
                
            BasicTextFiled(label: "매출액", placeHolder: "예상 매출액을 입력해주세요", inputText: $매출액, checkRed: false)
            
            Spacer()
            
            Button {
                //
            } label: {
                BasicButtonLabel(text: "저장")
            }
            .padding(.bottom, 10)


            }
        .padding(.horizontal, 15)
        }
}

struct AddBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        AddBusinessView()
    }
}
