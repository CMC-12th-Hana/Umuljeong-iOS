//
//  ImportEmployeeLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct ImportEmployeeLabel: View {
    var title:String = "참여 구성원"
    var count:Int
    var body: some View {
        ZStack {
            HStack(spacing:0){
                
                profileCircle
                    .padding(.trailing, 15)
                
                Text(title)
                    .font(.body2)
                    .foregroundColor(Color("font1"))
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text(count > 0 ? String(count) : "")
                            .font(.body1)
                            .foregroundColor(Color("main"))
                    
                    ImageBox(rectangleSize: 24, image: Image("rightArrow"))
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("bg3"))
        )
    }
    
    var profileCircle: some View {
        ZStack(alignment: .bottom) {
            Circle()
                .fill(Color("bg2"))
                .frame(width: 40, height: 40)
            
            
            Rectangle()
                .fill(Color.clear)
                .frame(width:34, height:34)
                .overlay(
                    ZStack{
                        Image("defaultUserLarge")
                            .padding(.top, 3.15)
                    }
                    .frame(width:34, height:34)
                    .clipShape(Circle())
                )
            
        }
        .frame(width: 40, height: 40)
    }
}

struct ImportEmployeeLabel_Previews: PreviewProvider {
    static var previews: some View {
        ImportEmployeeLabel(count: 0)
    }
}
