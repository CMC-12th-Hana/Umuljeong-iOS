//
//  InValidJoinAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/07.
//

import SwiftUI

struct InValidJoinAlert: View {
    @Binding var showPopup:Bool
    
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 15){
                Text("아래 그룹에 등록된 휴대폰 번호입니다")
                    .font(.body1)
                    .foregroundColor(Color("main"))
                
                VStack(spacing: 0) {
                    Text("그룹 담당자에게 휴대폰 번호 등록을")
                    Text("요청해보세요.")
                }
            }
            .frame(height: 141)
            
            VStack(spacing: 0){
                Divider()
                HStack(spacing:11) {
                    Button {
                        showPopup.toggle()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 56)
                            Text("확인")
                                .foregroundColor(Color("main"))
                                .font(.body1)
                        }
                    }
                }
            }
            .frame(height: 56)
        }
        .frame(height: 197)
    }
    
    var groupNameLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color("serve1"))
            HStack{
                Text("번호가 등록된 그룹 이름")
                    .font(.body3)
                Spacer()
                ImageBox(rectangleSize: 20, image: Image("rightArrow"))
            }
            .padding(.horizontal, 15)
        }
    }
}

struct InValidJoinAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        InValidJoinAlert(showPopup: $showPopup)
    }
}
