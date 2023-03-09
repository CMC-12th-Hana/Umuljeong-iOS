//
//  ClientView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
// 1View(Presentation) -> 2ViewModel -> 3Model 

import SwiftUI

struct ClientView: View {
    @State private var isShowingSheetStartDate = false
    @Binding var selectedTab: Tags
    @State private var searchText = ""
    @ObservedObject var viewModel = ClientViewModel()
    
    var body: some View {
            VStack(spacing:20) {
                customNavigationBar
                
                Divider()
                
                NavigationLink {
                    EditClientView(to: .add)
                        .navigationTitleFontDefault(title: "기업 추가하기")
                } label: {
                    PlusButtonLabel(label: "고객사 추가하기")
                }
                
                ScrollView() {
                    LazyVStack(spacing: 10) {
                    ForEach(viewModel.clientFeedInfo, id: \.clientId) { client in
                        NavigationLink {
                            DetailClientView(clientId: client.clientId, isShowingSheet: $isShowingSheetStartDate)
                        } label: {
                            CustomerCell(customer: client.name, visitCount: client.taskCount, businessCount: client.businessCount)
                        }
                        }
                    }
                }
                  //화면 터치시 키보드 숨김
                .onTapGesture {
                    hideKeyboard()
                }
                .onAppear{
                    viewModel.requestAllClient()
                }
            
        }
    }
}

extension ClientView {
    var customNavigationBar: some View {
        HStack {
            SearchBar(text: $viewModel.searchText, guideText: "찾으시는 고객사명을 입력해주세요")
            // MARK: - 필터 기능 : 후순위
//            Button {
//
//            } label: {
//                Image("sortList")
//            }
        }
        .frame(height: 61)
    }
}

struct CustomerView_Previews: PreviewProvider {
    @State static var selectedTab = Tags.tag1
    static var previews: some View {
        ClientView(selectedTab: $selectedTab)
    }
}


