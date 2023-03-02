//
//  WorkLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct CategoryLabel: View {
    let label:String
    let color:CategoryColor
    
    var body: some View {
        ZStack {
            Text(label)
                .font(.body3)
                .foregroundColor(setCategoryColor(color))
                .padding(.vertical, 9)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(setCategoryColor(color).opacity(0.4), lineWidth: 1)
                )
        }
    }
}

struct CategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLabel(label: "영업", color: .first)
    }
}
