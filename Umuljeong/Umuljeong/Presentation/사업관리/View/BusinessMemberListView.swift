//
//  BusinessMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct BusinessMemberListView: View {
    @StateObject var viewModel = BusinessMemberListViewModel()
    let businessId: Int
    var body: some View {
        VStack(spacing:20){
            searchArea
                .defaultAppStyleHorizentalPadding()
            
            Rectangle()
                .fill(Color("line2"))
                .frame(width: UIScreen.main.bounds.width, height: 1)
            
            ScrollView() {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.memberFeedInfo, id: \.id) { member in
                        MemberLabel(memberInfo: MemberSummaryModel(name: member.name, isLeader: false))
                    }
                }
            }
            .defaultAppStyleHorizentalPadding()
        }
        .navigationDesignDefault(title: "참여 구성원")
        .navigationBarItems(
            trailing:
                NavigationLink(destination: {
                    AddBusinessMemberView(to: .fix(businessId))
                }, label: {
                    Image("pencil")
                })
        )
        
        .onAppear{
            viewModel.requestMember(businessId: businessId)
        }
    }
        
    var searchArea: some View {
        HStack(spacing: 15){
            SearchBar(text: $viewModel.searchText, guideText: "찾으시는 구성원명을 입력해주세요")
        }
    }
}

struct BusinessMemberView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessMemberListView(businessId: 0)
    }
}
