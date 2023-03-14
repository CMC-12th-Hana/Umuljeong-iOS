//
//  TaskGraphLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct TaskGraphLabel: View {
    var title:String = "업무 현황 그래프"
    var body: some View {
        ZStack {
            HStack(spacing:0){
        
                ImageBox(rectangleSize: 30, image: Image("graph"))
                    .padding(.trailing, 20)
                
                Text(title)
                    .font(.body2)
                    .foregroundColor(Color("font1"))
                
                Spacer()
                
                ImageBox(rectangleSize: 24, image: Image("rightArrow"))
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
}

struct TaskGraphLabel_Previews: PreviewProvider {
    static var previews: some View {
        TaskGraphLabel()
    }
}
