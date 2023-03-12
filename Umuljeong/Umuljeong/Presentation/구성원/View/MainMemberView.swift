//
//  MainMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct MainMemberView: View {
    @ObservedObject var viewModel = MemberViewModel()
    @Binding var selectedTab: Tags
    @State var searchText:String = ""
    let myMemberId = Int(ApiManager.shared.myMemberId() ?? "-1") ?? -1
//    var isLeader:Bool = false
    
    var body: some View {
        VStack(spacing:20){
            searchArea
                .defaultAppStyleHorizentalPadding()
            
            Rectangle()
                .fill(Color("line2"))
                .frame(width: UIScreen.main.bounds.width, height: 1)
            
            ScrollView() {
                
                
                LazyVStack(spacing: 10) {
                    NavigationLink {
                        MyProfileView()
                    } label: {
                        UserLabel(memberInfo: MemberSummaryModel(name: viewModel.myInfo.name, isLeader: viewModel.myInfo.role == "리더"))
                    }
                    
                    ForEach(viewModel.memberFeedInfo.filter{$0.memberId != myMemberId}, id: \.memberId) { member in
                        NavigationLink {
                            MemberProfileView(memberId: member.memberId)
                        } label: {
                            MemberLabel(memberInfo: MemberSummaryModel(name: member.name, isLeader: member.role == "리더"))
                        }
                    }
                }
            }
            .defaultAppStyleHorizentalPadding()
        }
        .onAppear{
            viewModel.requestMyinfo()
            viewModel.requestAllMember()
        }
    }
    
    var searchArea: some View {
        HStack(spacing: 15){
            SearchBar(text: $searchText, guideText: "찾으시는 고객사명을 입력해주세요")
                
            if let role = ApiManager.shared.myRole(), role == true {
                NavigationLink(destination: {
                    AddMemberView()
                }, label: {
                    ImageBox(rectangleSize: 24, image: Image("bluePlusButton"))
                })
            }
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    @State static var selectedTab = Tags.tag4
    @State var searchText:String = ""
    static var previews: some View {
        MainMemberView(selectedTab: $selectedTab)
    }
}
