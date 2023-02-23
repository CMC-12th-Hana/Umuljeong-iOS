//
//  BasicLineButtonLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

struct BasicLineButtonLabel: View {
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: "plus")
            Text("사업 추가하기")
                .font(.body2)
            Spacer()
        }
        .foregroundColor(Color("font1"))
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color("font1"), lineWidth: 1.5)
        )
    }
}

struct BasicLineButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        BasicLineButtonLabel()
    }
}
