//
//  PlusButtonLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct PlusButtonLabel: View {
    let label:String
    var body: some View {
        VStack(spacing:0){
            HStack{
                Spacer()
                Image(systemName: "plus")
                Text(label)
                    .font(.body2)
                Spacer()
            }
            .frame(height: 54)
            .foregroundColor(Color("font1"))
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("font1"), lineWidth: 1.5)
            )
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
            )
        }
    }
}

struct PlusButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonLabel(label: "사업 추가하기")
    }
}
