//
//  UserLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct UserLabel: View {
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
                .frame(width: 50, height: 50)

            Rectangle()
                .fill(Color.clear)
                .frame(width: 42.5, height: 42.5)
                .overlay(
                    ZStack{
                        Image("defaultUserLarge")
                            .resizable()
                            .frame(width:28.9, height:39)
                    }
                    .frame(width: 42.5, height: 42.5)
                    .clipShape(Circle())
                ,alignment: .bottom)
                .padding(.top, 10)
            
        }
        .frame(width: 50, height: 50)
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

struct UserLabel_Previews: PreviewProvider {
    static var previews: some View {
        UserLabel(memberInfo: MemberSummaryModel(name: "구성원 이름", isLeader: true))
    }
}
