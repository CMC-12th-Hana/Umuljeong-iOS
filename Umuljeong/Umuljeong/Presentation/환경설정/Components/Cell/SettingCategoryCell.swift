//
//  SettingCategoryCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct SettingCategoryCell: View {
    let imageName: String
    let name: String
    
    var body: some View {
        HStack (spacing: 10) {
            ZStack{
                Image(imageName)
                    .frame(width:25)
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 32, height: 32)
            Text(name)
                .font(.body2)
                .foregroundColor(Color("font1"))
            Spacer()
            Image("rightArrow")
                .padding(12)
        }
        .frame(height: 60)
    }
}

struct SettingCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingCategoryCell(imageName: "bellDefault", name: "훔냐냐")
    }
}
