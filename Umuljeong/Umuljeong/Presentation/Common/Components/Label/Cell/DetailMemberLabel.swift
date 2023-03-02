//
//  DetailMemberLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/01.
//

import SwiftUI

struct DetailMemberLabel: View {
    let imageName: String
    let title: String
    let info: String
    
    var body: some View {
        ZStack{
            HStack(spacing: 10){
                ImageBox(rectangleSize: 24, image: Image(imageName))
                Text(title)
                    .font(.special3)
                Text(info)
                    .font(.body3)
                Spacer()
            }
            .padding(20)
        }
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
                .frame(height: 60)
        )
    }
}

struct DetailMemberLabel_Previews: PreviewProvider {
    static var previews: some View {
        DetailMemberLabel(imageName: "companyDark", title: "회사명", info: "회사명이 들어갑니다")
    }
}
