//
//  CompanyListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
// 1View(Presentation) -> 2ViewModel -> 3Model 

import SwiftUI

struct CustomerView: View {
    @Binding var selectedTab: Tags
    @State private var searchText = ""
    
    let array:[CustomerListModel] = [
            CustomerListModel(customer: "디지털리얼코리아", visitCount: 27, businessCount: 27), CustomerListModel(customer: "복실이월드", visitCount: 100, businessCount: 0)
        ]
    
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                HStack(spacing: 0){
                    SearchBar(text: $searchText, guideText: "찾으시는 고객사명을 입력해주세요")
                        .padding(.trailing, 15)
                    
                    Button {
                        
                        //
                    } label: {
                        Image("sortList")
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                Divider()
                
                NavigationLink {
                    AddCustomerView()
                        .navigationTitleFontDefault(title: "기업 추가하기")
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("고객사 추가하기")
                            .font(.body2)
                    }
                    .foregroundColor(Color("font1"))
                    .frame(width: 335, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("font1"), lineWidth: 1.5)
                    )
                }
                

                .frame(width: 335)
                ScrollView() {
                    ForEach(array.filter{$0.customer.hasPrefix(searchText) || searchText == ""}) {
                        searchResult in
                        NavigationLink {
                            DetailCustomerView()
                        } label: {
                            CustomerCell(customer: searchResult.customer, visitCount: searchResult.visitCount, businessCount: searchResult.businessCount)
                        }
                    }
                    .frame(width: 335)
                }
                  //화면 터치시 키보드 숨김
                .onTapGesture {
                    hideKeyboard()
                }
            }
        }
    }
}

struct CustomerView_Previews: PreviewProvider {
    @State static var selectedTab = Tags.tag1
    static var previews: some View {
        CustomerView(selectedTab: $selectedTab)
    }
}


//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
