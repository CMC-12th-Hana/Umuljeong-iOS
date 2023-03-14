//
//  CategoryDeleteOptionCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/22.
//

import SwiftUI

struct CategoryDeleteOptionCell: View {
    @State var isSelected:Bool = false
    let category:String
    let categoryColor:CategoryColor
    
    var body: some View {
        ZStack {
            HStack{
                HStack(spacing: 10){
                    Circle()
                        .stroke(Color("line2"), lineWidth: 1)
                        .frame(width: 20)
                        .overlay(
                            Circle()
                                .fill(isSelected ? Color("main") : Color("line3"))
                                .padding(5)
                                    )
                    Text(category)
                        .font(.body2)
                }

                Spacer()
                
                CategoryLabel(label: category, color: categoryColor)
            }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg3"))
                )
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct CategoryDeleteOptionCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDeleteOptionCell(category: "A/S", categoryColor: .first)
    }
}
