//
//  AddButtonLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct AddButtonLabel: View {
    let label:String
    var body: some View {
        VStack(spacing:0){
            HStack{
                Text(label)
                    .font(.body2)
                    .foregroundColor(Color("font1"))
                Spacer()
                ImageBox(rectangleSize: 24, image: Image("rightArrow"))
            }
            .padding(.horizontal, 15)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("line2"), lineWidth: 1)
            )
        }
    }
}

struct AddButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonLabel(label: "고객사명")
    }
}
