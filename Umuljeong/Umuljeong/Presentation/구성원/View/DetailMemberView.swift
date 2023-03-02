//
//  DetailMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/01.
//

import SwiftUI

struct DetailMemberView: View {
    var memberInfo: MemberSummaryModel
    var body: some View {
        VStack(spacing: 0){
            profileCircle
                .padding(.top, 50)
            memberName
            
            deleteButton
                .padding(.top, 32)
            
            VStack(spacing: 10){
                DetailMemberLabel(imageName: "companyDark", title: "회사명", info: "회사명이 들어갑니다")
                DetailMemberLabel(imageName: "companyDark", title: "연락처", info: "02-1234-****")
                DetailMemberLabel(imageName: "companyDark", title: "직급", info: "사원")
                DetailMemberLabel(imageName: "companyDark", title: "사번", info: "176975")
            }
            .padding(.top, 10)
            
        }
        .navigationDesignDefault(title: "프로필 상세")
    }
    
    var profileCircle: some View {
        ZStack {
            Circle()
                .fill(Color("bg2"))
                .frame(width: 66, height: 66)
                .overlay(
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 56.1, height: 56.1)
                        .overlay(
                            Image("defaultUserLarge")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:38.15)
                        , alignment: .bottom
                        )
                        .clipShape(Circle())
                    , alignment: .bottom)
        }
    }
    
    var memberName: some View {
        HStack(spacing:0) {
            Spacer()
                .frame(width: 37, height: 21)
            
            Text(memberInfo.name)
                .font(.special2)
            
            LeaderLabel(width: 31, height: 21)
                .padding(.leading, 6)
        }
    }
    
    var deleteButton:some View {
        HStack{
            Spacer()
            
            Button {
                
            } label: {
                Text("수정")
                    .font(.body6)
                    .foregroundColor(Color("font1"))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("line1"), lineWidth: 1)
                    )
            }
            .padding(.trailing, 11)
        }
    }
}

struct DetailMemberView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMemberView(memberInfo: MemberSummaryModel(name: "박보노", isLeader: true))
    }
}
