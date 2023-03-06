//
//  LoginFailAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import SwiftUI

struct LoginFailAlert: View {
    @Binding var showPopup:Bool
    
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 15){
                Text("로그인에 실패하였습니다.")
                    .font(.body1)
                    .foregroundColor(Color("main"))
                
                Text("핸드폰 번호 또는 비밀번호를 확인해 보세요")
                    .font(.body2)
            }
            .frame(height: 119)
            
            VStack(spacing: 0){
                Divider()
                HStack(spacing:11) {
                    Button {
                        hideKeyboard()
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
        }
    }
}

struct LoginFailAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        LoginFailAlert(showPopup: $showPopup)
    }
}
