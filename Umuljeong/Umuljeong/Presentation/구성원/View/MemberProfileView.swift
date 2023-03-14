//
//  DetailMemberView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/01.
//

import SwiftUI

struct MemberProfileView: View {
    @ObservedObject var viewModel = MemberProfileViewModel()
    @State var isLoaded: Bool = false
    let memberId:Int
    let myRole = ApiManager.shared.myRole() ?? true //출시 시 기본 상태 true로
    
    var body: some View {
        VStack(spacing: 0){
            profileCircle
                .padding(.top, 50)
            memberName
            
            if myRole {
                fixButton
                    .padding(.top, 32)
            }
            
            VStack(spacing: 10){
                DetailMemberLabel(imageName: "companyDark", title: "회사명", info: viewModel.memberInfo.companyName)
                DetailMemberLabel(imageName: "companyDark", title: "연락처", info: viewModel.memberInfo.phoneNumber)
                DetailMemberLabel(imageName: "companyDark", title: "직급", info: viewModel.memberInfo.staffRank)
                DetailMemberLabel(imageName: "companyDark", title: "사번", info: viewModel.memberInfo.staffNumber)
            }
            .padding(.top, 10)
            
        }
        .navigationDesignDefault(title: "프로필 상세")
        .onAppear{
            viewModel.requestMemberInfo(memberId: self.memberId) { result in
                    if result {
                        print("요고요고 확인중")
                        isLoaded = true
                        
                    } else {
                        isLoaded = false
                    }
            }
        }
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
            if viewModel.memberInfo.role == "리더" {
                Spacer()
                    .frame(width: 37, height: 21)
            }
            
            Text(viewModel.memberInfo.name)
                .font(.special2)
            if viewModel.memberInfo.role == "리더" {
                LeaderLabel(width: 31, height: 21)
                    .padding(.leading, 6)
            }
        }
    }
    
    var fixButton:some View {
        HStack{
            Spacer()
            NavigationLink {
                FixMemberProfileView(userInfo: viewModel.memberInfo)
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
        MemberProfileView(memberId: 0)
    }
}
