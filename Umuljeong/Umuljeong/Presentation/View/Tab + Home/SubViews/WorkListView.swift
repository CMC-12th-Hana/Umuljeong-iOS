//
//  WorkListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct TeskListView: View {
    var isListEmpty:Bool = false //기본 값 true
    
    var body: some View {
        if isListEmpty {
            VStack{
                Text("표시할 목록이 없습니다").font(.custom("Pretendard Medium", size: 14)).tracking(0.46)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {
            VStack{
                NavigationLink {
                    AddTaskView()
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("업무 추가하기")
                            .font(.custom("Pretendard-Bold", size: 16))
                    }
                    .foregroundColor(Color("font1"))
                    .frame(width: 335, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("font1"), lineWidth: 1.5)
                    )
                } //: NavigationLink - AddTaskView
                
                ScrollView {
                    WorkListCell(work: "디지툴리얼코리아 전용 회선", custumer: "디지털 리얼 코리아", category: "문의", categoryColor: Color("main"))
                        .frame(width: 335)
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
