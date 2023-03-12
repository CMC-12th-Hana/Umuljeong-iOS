//
//  AddBusinessMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct AddBusinessMemberView: View {
    @StateObject var viewModel = AddBusinessMemberViewModel() //앞 View에서 계속 호출돼서 State로 변경 
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            searchView
            ScrollView() {
                
//                if !viewModel.leaderInfo.isEmpty {
//                    let leader = viewModel.leaderInfo.first
//                    SelectMemberLabel(memberName: leader?.name ?? "리더")
//                }
                
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.selectMemberInfo, id: \.memberId) { member in
                        Button {
                            viewModel.deselectMember(id: member.memberId)
                        } label: {
                            SelectMemberLabel(memberName: member.name)
                        }
                    }
                }
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.deselectMemberInfo.filter{if viewModel.searchText == "" {return true} else { return $0.name.contains(viewModel.searchText)}}, id: \.memberId) { member in
                        Button {
                            viewModel.selectMember(id: member.memberId)
                        } label: {
                            DeselectMemberLabel(memberName: member.name)
                        }
                    }
                }
            }
            
            Button {
                viewModel.saveMemberIdList()
                presentationMode.wrappedValue.dismiss()
            } label: {
                BasicButtonLabel(text: "저장")
            }
            
        }
        .onDisappear{
            viewModel.resetViewModelIdListData()
        }
        .onAppear{
            viewModel.loadSelectIdList()
        }
        .navigationDesignDefault(title: "참여 구성원 추가하기")
    }
    
    var searchView: some View {
        SearchBar(text: $viewModel.searchText, guideText: "찾으시는 구성원명을 입력해주세요")
    }
        
}

struct AddBusinessMemberView_Previews: PreviewProvider {
    static var memberIdList:[Int] = []
    
    static var previews: some View {
        AddBusinessMemberView()
    }
}
