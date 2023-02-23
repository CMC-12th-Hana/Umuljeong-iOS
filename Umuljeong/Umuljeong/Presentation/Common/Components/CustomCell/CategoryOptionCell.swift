//
//  CategoryOptionCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct CategoryOptionCell: View {
    let category:String
    let categoryColor:CategoryColor
    
    var body: some View {
        ZStack {
            HStack{
                Text(category)
                    .font(.body2)
                    .foregroundColor(Color("font1"))

                Spacer()
                
                CategoryLabel(label: category, color: categoryColor)
            }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg3"))
                )
        }
    }
}

struct CategoryOptionCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryOptionCell(category: "A/S", categoryColor: .first)
    }
}
