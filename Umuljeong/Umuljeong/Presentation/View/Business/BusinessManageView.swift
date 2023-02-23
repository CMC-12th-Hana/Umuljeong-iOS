//
//  BusinessManageView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/11.
//

import SwiftUI

struct BusinessManageView: View {
    @Binding var selectedTab: Int
    @ObservedObject var viewModel = BusinessManagerViewModel()
    @State var searchWord: String = ""
    
    var body: some View {
        VStack{
            SearchBar(text: $searchWord, guideText: "찾으시는 사업명을 입력해주세요")
                .padding(.bottom, 10)
            
            StartFinishDateView(showStartCalendar: $viewModel.showStartCalendar, showFinishCalendar: $viewModel.showFinishCalendar, startDateString: viewModel.startDateString, finishDateString: viewModel.finishDateString)
                .padding(.bottom, 20)
            Divider()
                .padding(.bottom, 30)
            
            HStack(spacing:0){
                Image("businessImage")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(.trailing, 10)
                Text("내가 참여중인 사업")
                    .font(.body2)
                Spacer()
            }
            
            ScrollView{
                BusinessCell()
                BusinessCell()
                BusinessCell()
                
            }
        }
        .padding(.horizontal, 15)
    }
}

struct BusinessManageView_Previews: PreviewProvider {
    @State static var selectedTab = 2
    static var previews: some View {
        BusinessManageView(selectedTab: $selectedTab)
    }
}
