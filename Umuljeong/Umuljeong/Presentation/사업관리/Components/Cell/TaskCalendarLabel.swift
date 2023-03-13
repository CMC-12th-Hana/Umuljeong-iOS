//
//  TaskCalendarLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct TaskCalendarLabel: View {
    var title:String = "날짜별 업무 현황"
    var body: some View {
        ZStack {
            HStack(spacing:0){
                
                ImageBox(rectangleSize: 30, image: Image("calendar"))
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

struct TaskCalendarLabel_Previews: PreviewProvider {
    static var previews: some View {
        TaskCalendarLabel()
    }
}
