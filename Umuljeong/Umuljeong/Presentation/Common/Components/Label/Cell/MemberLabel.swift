//
//  MemberLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/28.
//

import SwiftUI

struct MemberLabel: View {
    let memberInfo: MemberSummaryModel
    
    var body: some View {
        ZStack {
            HStack(spacing:13){
                profileCircle
                memberName
                if memberInfo.isLeader {
                    LeaderLabel(width: 30, height: 17)
                }
                Spacer()
                rightArrowImage
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
    
    var memberName:Text {
        Text(memberInfo.name)
            .font(.body2)
            .foregroundColor(Color("font1"))
    }
    
    var rightArrowImage: some View {
        ImageBox(rectangleSize: 24, image: Image("rightArrow"))
    }
    
}

struct MemberLabel_Previews: PreviewProvider {
    static var previews: some View {
        MemberLabel(memberInfo: MemberSummaryModel(name: "구성원 이름", isLeader: true))
    }
}
