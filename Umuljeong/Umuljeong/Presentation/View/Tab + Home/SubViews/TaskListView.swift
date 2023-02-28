//
//  TaskListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct TaskListView: View {
    @Binding var viewModel:CalendarViewModel
    
    var isListEmpty:Bool = false //기본 값 true
    var teskList:[TeskModel] = [TeskModel(work: "디지털코리아 전용 회선", customer: "디지털 코리아", category: "문의"), TeskModel(work: "복실이 랜드", customer: "복실공주", category: "간식이 좋아")]
    
    var body: some View {
        if isListEmpty {
            VStack{
                Text("표시할 목록이 없습니다").font(.custom("Pretendard Medium", size: 14))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {
            VStack(spacing: 20){
                NavigationLink {
                    AddTaskView(selecteDate: viewModel.getDate())
                } label: {
                    PlusButtonLabel(label: "업무 추가하기")
                }
                
                ScrollView{
                    ForEach(teskList) { tesk in
                        NavigationLink {
                            DetailTaskView()
                        } label: {
                            WorkListCell(work: tesk.work, customer: tesk.customer, category: tesk.category, categoryColor: .first)
                        }
                    } // : ForEach
                } // : ScrollView
            }
            .defaultAppStyleHorizentalPadding()
        }
    }
}

struct TeskListView_Previews: PreviewProvider {
    @State static var viewModel = CalendarViewModel()
    static var previews: some View {
        TaskListView(viewModel: $viewModel)
    }
}
