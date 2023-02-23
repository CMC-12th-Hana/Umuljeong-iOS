//
//  WorkListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct TeskListView: View {
    var isListEmpty:Bool = false //기본 값 true
    var teskList:[TeskModel] = [TeskModel(work: "디지털코리아 전용 회선", customer: "디지털 코리아", category: "문의"), TeskModel(work: "복실이 랜드", customer: "복실공주", category: "간식이 좋아")]
    
    var body: some View {
        if isListEmpty {
            VStack{
                Text("표시할 목록이 없습니다").font(.custom("Pretendard Medium", size: 14)).tracking(0.46)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {
            
            
            VStack(spacing: 15){
                NavigationLink {
//                    AddTaskView()
                } label: {
                    PlusButtonLabel(label: "업무 추가하기")
                }
                .padding(.top, 15)
                //: NavigationLink - AddTaskView
                
                ScrollView{
                    ForEach(teskList) { tesk in
                        NavigationLink {
//                            AddTaskView()
                        } label: {
                            WorkListCell(work: tesk.work, customer: tesk.customer, category: tesk.category, categoryColor: .first)
                        }
                    } // : ForEach
                    .frame(minHeight: 85)
                    .fixedSize(horizontal: true, vertical: false)
                } // : ScrollView
            }
        }
    }
}

struct TeskListView_Previews: PreviewProvider {
    static var previews: some View {
        TeskListView()
    }
}
