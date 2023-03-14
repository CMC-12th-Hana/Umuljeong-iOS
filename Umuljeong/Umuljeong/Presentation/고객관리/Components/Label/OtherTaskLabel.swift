//
//  OtherTaskLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct OtherTaskLabel: View {
    var body: some View {
        ZStack {
                HStack(alignment:.center, spacing:8){
                    Text("기타업무")
                        .padding(.leading, 14)
                        .padding(.trailing, 4)
                    Image("info")
                    Spacer()

                    Image("rightArrow")
                        .padding(.trailing, 24)

                }//: HStack
                .frame(height: 70)
                .foregroundColor(Color("font1"))
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("bg2"))
                )
        }
    }
}

struct OtherTaskLabel_Previews: PreviewProvider {
    static var previews: some View {
        OtherTaskLabel()
    }
}
