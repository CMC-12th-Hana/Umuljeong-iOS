//
//  TaskWithCategoryCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import SwiftUI

struct TaskWithCategoryCell: View {
    let taskTitle:String
    let categoryName:String
    let categoryColor:CategoryColor
    @State private var onTapped: Bool = false
    
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment:.leading, spacing: 3){
                    Text(taskTitle)
                        .font(.body2)
                        .foregroundColor(Color("font1"))
                    
                }
                Spacer()
                
                CategoryLabel(label: categoryName, color: categoryColor)
            }
            .padding(.horizontal, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(onTapped ? Color("bg3") : .white)
                .frame(height: 60)
        )
        .frame(height: 60)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    self.onTapped = true
                }
                .onEnded { _ in
                    self.onTapped = false
                }
        )
    }
}

struct TaskWithCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskWithCategoryCell(taskTitle: "디지툴리얼코리아 전용 회선", categoryName: "문의", categoryColor: .first)
    }
}
