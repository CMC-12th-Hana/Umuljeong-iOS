//
//  MainMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct MainMemberView: View {
    @Binding var selectedTab: Tags
    @State var searchText:String = ""
    var isLeader:Bool = false
    
    var body: some View {
        VStack(spacing:20){
            searchArea
                .defaultAppStyleHorizentalPadding()
            
            Rectangle()
                .fill(Color("line2"))
                .frame(width: UIScreen.main.bounds.width, height: 1)
            
            ScrollView{
                MemberLabel(memberInfo: MemberSummaryModel(name: "티나", isLeader: true))
                MemberLabel(memberInfo: MemberSummaryModel(name: "뽀로로", isLeader: false))
                MemberLabel(memberInfo: MemberSummaryModel(name: "뽀노뽀", isLeader: false))
                MemberLabel(memberInfo: MemberSummaryModel(name: "뽀노", isLeader: false))
                MemberLabel(memberInfo: MemberSummaryModel(name: "뽀로로", isLeader: false))
                MemberLabel(memberInfo: MemberSummaryModel(name: "노보노보", isLeader: false))
            }
            .defaultAppStyleHorizentalPadding()
        }
    }
    
    var searchArea: some View {
        HStack(spacing: 15){
            SearchBar(text: $searchText, guideText: "찾으시는 고객사명을 입력해주세요")

            Button {
                //
            } label: {
                ImageBox(rectangleSize: 24, image: Image("setting"))
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
