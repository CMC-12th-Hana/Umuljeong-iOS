//
//  ImportEmployeeLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct ImportEmployeeLabel: View {
    var body: some View {
        ZStack {
            HStack(spacing:0){
                
                Image("defaultUserLarge")
                    .padding(9)
                    .background(
                        Circle()
                            .fill(Color("bg2"))
                    )
                    .padding(.trailing, 20)
                
                Text("사원 프로필 가져오기")
                    .foregroundColor(Color("font1"))
                
                Spacer()
                
                Image("rightArrow")
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
}

struct ImportEmployeeLabel_Previews: PreviewProvider {
    static var previews: some View {
        ImportEmployeeLabel()
    }
}
