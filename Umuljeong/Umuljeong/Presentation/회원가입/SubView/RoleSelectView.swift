//
//  RoleSelectView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct RoleSelectView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                goCompanyView
                goJoiningView
            }
        }
    }
    
    
    var goCompanyView: some View {
            NavigationLink {
                CompanyCreateView()
            } label: {
                VStack(spacing: 15) {
                    Image("company")
                    Text("새 회사 만들기")
                        .font(.custom("Pretendard-Bold", size: 18))
                    Text("회사에 #을 도입해 보시겠어요?")
                        .font(.custom("Pretendard-Bold", size: 14))
                }
            }
            .frame(width: 335, height: 230)
            .foregroundColor(Color("main"))
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("main"), lineWidth: 1.5)
            )
            .navigationTitle("")
    }
        
        
    var goJoiningView: some View {
        VStack(spacing: 15) {
            Image("joining")
            Text("합류햐기")
                .font(.custom("Pretendard-Bold", size: 18))
            Text("우리 회사에서 #를 이미 사용하고 있어요.")
                .font(.custom("Pretendard-Bold", size: 14))
        }
        .frame(width: 335, height: 230)
        .foregroundColor(Color("main"))
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color("main"), lineWidth: 1.5)
        )
//        .fullScreenCover(isPresented: $signUpButtonState) {
//            RoleSelectView()
//
//        }
    }
}

struct RoleSelectView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectView()
    }
}
