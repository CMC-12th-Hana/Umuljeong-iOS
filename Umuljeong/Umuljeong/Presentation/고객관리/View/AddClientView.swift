//
//  AddCustomerView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct AddClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = AddClientViewModel()
    @State var alertNetworkError: Bool = false
    @State var to: PageType
    
    enum PageType {
        case add
        case edit
    }
    
    var clientId: Int?
    
    var body: some View {
        VStack{
            VStack(spacing:17) {
                BasicTextFiled(label: "기업 이름", placeHolder: "기업 이름을 입력해주세요", inputText: $viewModel.customerName)
                BasicTextFiled(label: "기업 대표 전화", placeHolder: "기업 대표 전화번호를 입력해주세요", inputText: $viewModel.customerMainCall)
            }
            .padding(.vertical, 30)
            .defaultAppStyleHorizentalPadding()

            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("bg2"))
            )
            Group{
                VStack(alignment:.leading){
                    Text("해당 고객사 영업 담당")
                        .font(.customTitle2)
                        .padding(.vertical, 30)
                    BasicTextFiled(label: "부서명", placeHolder: "부서명을 입력해주세요", inputText: $viewModel.partName, checkRed: false)
                    
                        .padding(.bottom, 20)
                    VStack(spacing: 8){
                        BasicTextFiled(label: "담당자명 및 전화번호", placeHolder: "담당자명을 입력해주세요", inputText: $viewModel.partManagerName, checkRed: false)
                        BasicTextFiled(label: "없어", placeHolder: "담당자의 전화번호를 입력해주세요", inputText: $viewModel.partManagerCall, checkRed: false, isLabel: false)
                    }
                }
                Spacer()
                Button {
                    switch to {
                    case .add:
                        viewModel.requestCreateNewClient { result in
                            if result {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                alertNetworkError = true
                            }
                        }
                    case .edit:
                        viewModel.requestEditClient { result in
                            if result {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                alertNetworkError = true
                            }
                        }
                    }
                } label: {
                    BasicButtonLabel(text: "저장")
                }
            }
            .defaultAppStyleHorizentalPadding()
            
        }
        .navigationDesignDefault(title: "고객사 추가하기")
        .onAppear{
            guard let recivedClientId = clientId else {return} //수정하기 화면이었다면
            viewModel.requestCustomerInfo(clientId: recivedClientId) { result in
                if result {
                    //불러오기 완료 전까지 똥글뺑이
                } else {
                    alertNetworkError = true
                }
            }
        }
    }
}

struct AddCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        AddClientView(to: .add)
    }
}
