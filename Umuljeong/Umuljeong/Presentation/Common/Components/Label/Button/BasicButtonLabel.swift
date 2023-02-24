//
//  BasicButtonLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct BasicButtonLabel: View {
    let text:String
    
    var body: some View {
        HStack{
            Spacer()
            Text(text)
                .font(.body1)
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("main"))
        )
    }
}

struct BasicButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        BasicButtonLabel(text: "저장")
    }
}
