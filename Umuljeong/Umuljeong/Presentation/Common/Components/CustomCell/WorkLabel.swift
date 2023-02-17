//
//  WorkLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct WorkLabel: View {
    let label:String
    let color:Color
    
    var body: some View {
        ZStack {
            Text(label)
                .font(.custom("Pretendard-Regular", size: 16))
                .foregroundColor(color)
                .padding(.vertical, 9)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(color.opacity(0.7), lineWidth: 1)
                )
        }
    }
}

struct WorkLabel_Previews: PreviewProvider {
    static var previews: some View {
        WorkLabel(label: "영업", color: Color("main"))
    }
}
