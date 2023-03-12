//
//  FixMemberLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct FixMemberLabel: View {
    @State var pick: Bool
    let memberName:String
    
    var body: some View {
        ZStack {
            HStack(spacing:13){
                profileCircle
                memberNameView

                Spacer()
                stateImage
            }
            .padding(.horizontal, 20)
            .frame(height: 70)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("bg3"))
                    .frame(height: 70)
            )
        }
    }
    
    var profileCircle: some View {
        ZStack {
            Circle()
                .fill(Color("bg2"))
                .frame(width: 40, height: 40)

            Rectangle()
                .fill(Color.clear)
                .frame(width: 34, height: 34)
                .overlay(
                    ZStack{
                        Image("defaultUserLarge")
                            .resizable()
                            .frame(width:23, height:31)
                    }
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())
                ,alignment: .bottom)
                .padding(.top, 6)
            
        }
    }
    
    var memberNameView:Text {
        Text(memberName)
            .font(.body2)
            .foregroundColor(Color("font1"))
    }
    
    var stateImage: some View {
        Group{
            if pick {
                ImageBox(rectangleSize: 24, image: Image("redMinusButton"))
            } else {
                ImageBox(rectangleSize: 24, image: Image("bluePlusButton"))
            }
        }
    }
}

struct FixMemberLabel_Previews: PreviewProvider {
    static let memberId = 1
    static var idList: [Int] = [0, 1]
    
    static var previews: some View {
        FixMemberLabel(pick: idList.contains(memberId), memberName: "구성원 이름")
    }
}
