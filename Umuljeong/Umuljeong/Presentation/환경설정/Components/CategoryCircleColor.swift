//
//  CategoryCircleColor.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/22.
//

import SwiftUI

struct CategoryCircleColor: View {
    @Binding var isSelected: CategoryColor
    let myColor: CategoryColor
    
    var body: some View {
        Circle()
            .fill(setCategoryColor(myColor).opacity(0.4))
            .frame(width: 42)
            .overlay(
                Circle()
                    .stroke(.black, lineWidth: isSelected == myColor ? 1 : 0)
                            )
            .onTapGesture {
                isSelected = myColor
            }
    }
}

struct CategoryCircleColor_Previews: PreviewProvider {
    @State static var isSelected: CategoryColor = .first
    static var previews: some View {
        CategoryCircleColor(isSelected: $isSelected, myColor: CategoryColor.first)
    }
}
