//
//  AddBusinessMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct AddBusinessMemberView: View {
    @StateObject var viewModel = AddBusinessMemberViewModel() //앞 View에서 계속 호출돼서 State로 변경
    let to:EditMemberPage
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
                switch to {
                case .add:
                    viewModel.saveMemberIdList()
                    presentationMode.wrappedValue.dismiss()
                case .fix(let businessId):
                    viewModel.requestFixBusinessMember(businessId: businessId) { result in
                        if result {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            print("멤버 수정 실패")
                        }
                    }
                }
                
            } label: {
                BasicButtonLabel(text: "저장")
            }
            
        }
        .onDisappear{
            switch to {
            case .add: break
            case .fix: viewModel.resetViewModelIdListData()
            }
        }
        .onAppear{
            switch to {
            case .add:
                viewModel.loadSelectIdList()
            case .fix(let businessId):
                viewModel.setBeforeFixIdList(businessId: businessId)
            }
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
        AddBusinessMemberView(to: .add(0))
    }
}

enum EditMemberPage {
    case add(Int)
    case fix(Int)
}
