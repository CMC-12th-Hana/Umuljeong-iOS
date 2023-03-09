//
//  AddCustomerView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct EditClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EditClientViewModel()
    @State var alertNetworkError: Bool = false //API 소통 시 필수 View
    @State var isLoaded: Bool = false
    @State var to: PageType //.add, .edit
    
    enum PageType {
        case add
        case edit(Int)
    }
    
    
    var body: some View {
        VStack{
            VStack(spacing:17) {
                BasicTextFiled(label: "기업 이름", placeHolder: "기업 이름을 입력해주세요", inputText: $viewModel.clientName)
                    
                BasicTextFiled(label: "기업 대표 전화", placeHolder: "기업 대표 전화번호를 입력해주세요", inputText: $viewModel.clientMainTel)
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
                    BasicTextFiled(label: "부서명", placeHolder: "부서명을 입력해주세요", inputText: $viewModel.department, checkRed: false)
                    
                        .padding(.bottom, 20)
                    VStack(spacing: 8){
                        BasicTextFiled(label: "담당자명 및 전화번호", placeHolder: "담당자명을 입력해주세요", inputText: $viewModel.partManagerName, checkRed: false)
                        BasicTextFiled(label: "없어", placeHolder: "담당자의 전화번호를 입력해주세요", inputText: $viewModel.partManagerTel, checkRed: false, isLabel: false)
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
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        .popupNavigationAlertView(height: 160, show: $alertNetworkError) {
            NetworkErrorAlert(message: viewModel.alertErrorMessage, showPopup: $alertNetworkError)
        }
        .navigationDesignDefault(title: "고객사 추가하기")
        .onAppear{
            switch to {
            case .add: return
            case .edit(let id):
                viewModel.requestCustomerInfo(clientId: id) { result in
                    if result {
                        //불러오기 완료 전까지 똥글뺑이
                        isLoaded = true
                        print(viewModel.clientName)
                    } else {
                        alertNetworkError = true
                    }
                }
            }
        }
    }
}

struct AddCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        EditClientView(to: .add)
    }
}
