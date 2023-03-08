//
//  CompanyListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
// 1View(Presentation) -> 2ViewModel -> 3Model 

import SwiftUI

struct CustomerView: View {
    @State private var isShowingSheetStartDate = false
    @Binding var selectedTab: Tags
    @State private var searchText = ""
    
    let array:[CustomerListModel] = [
            CustomerListModel(customer: "디지털리얼코리아", visitCount: 27, businessCount: 27), CustomerListModel(customer: "복실이월드", visitCount: 100, businessCount: 0)
        ]
    
    var body: some View {
            VStack(spacing:20) {
                customNavigationBar
                
                Divider()
                
                NavigationLink {
                    AddCustomerView(clientId: 0) // 선택한 고객사에 대한 아이디 전달
                        .navigationTitleFontDefault(title: "기업 추가하기")
                } label: {
                    PlusButtonLabel(label: "고객사 추가하기")
                }
                
                ScrollView() {
                    VStack(spacing: 10){
                        NavigationLink {
                            DetailCustomerView(isShowingSheet: $isShowingSheetStartDate)
                        } label: {
                            CustomerCell(customer: "ㅇㅇㄹ", visitCount: 13, businessCount: 13)
                        }
                        ForEach(array.filter{$0.customer.hasPrefix(searchText) || searchText == ""}) {
                            searchResult in
                            NavigationLink(isActive:$isShowingSheetStartDate) {
                                DetailCustomerView(isShowingSheet: $isShowingSheetStartDate)
                            } label: {
                                CustomerCell(customer: searchResult.customer, visitCount: searchResult.visitCount, businessCount: searchResult.businessCount)
                            }
                        }
                    }
                }
                  //화면 터치시 키보드 숨김
                .onTapGesture {
                    hideKeyboard()
                }
                .onAppear{
                    print("고객사 메인 화면 생성 반응함") //화면 로드 시 바로 getrequest 출력 
                }
        }
    }
}

extension CustomerView {
    var customNavigationBar: some View {
        HStack {
            SearchBar(text: $searchText, guideText: "찾으시는 고객사명을 입력해주세요")
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
        CustomerView(selectedTab: $selectedTab)
    }
}


