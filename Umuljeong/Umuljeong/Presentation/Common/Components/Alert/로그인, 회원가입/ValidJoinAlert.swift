//
//  ValidJoinAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/07.
//

import SwiftUI

struct ValidJoinAlert: View {
    @Binding var showPopup:Bool
    @Binding var moveMainTabView:Bool
    
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 15){
                Text("아래 그룹에 등록된 휴대폰 번호입니다")
                    .font(.body1)
                    .foregroundColor(Color("main"))
                
                groupNameLabel
                    .padding(.horizontal, 15)
                    .frame(height: 46)
            }
            .frame(height: 141)
            
            VStack(spacing: 0){
                Divider()
                HStack(spacing:11) {
                    Button {
                        showPopup.toggle()
                        moveMainTabView.toggle()
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

struct ValidJoinAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    @State static var moveMainTabView: Bool = false
    static var previews: some View {
        ValidJoinAlert(showPopup: $showPopup, moveMainTabView: $moveMainTabView)
    }
}
