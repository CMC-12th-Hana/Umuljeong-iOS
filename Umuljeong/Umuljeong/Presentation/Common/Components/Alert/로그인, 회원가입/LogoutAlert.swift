//
//  LogoutAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/14.
//

import SwiftUI

struct LogoutAlert: View {
    @Binding var showPopup:Bool
    var result:(Bool) -> ()
    let height:CGFloat = 122
    
    var body: some View {
        VStack(spacing:0) {
            HStack(spacing: 0){
                Text("Field Mate")
                    .foregroundColor(Color("main"))
                Text("에서 로그아웃하시겠어요?")
                    .foregroundColor(Color("font1"))
            }
            .frame(height: 72)
            .font(.body2)
            VStack(spacing: 0){
                Divider()
                HStack(spacing:11) {
                    Button {
                        result(false)
                        showPopup.toggle()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 56)
                            Text("취소")
                                .font(.body1)
                                .foregroundColor(Color("font1"))
                        }
                    }
                    
                    Divider()
                        .frame(height: 50)
                    
                    Button {
                        result(true)
                        showPopup.toggle()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 56)
                            Text("로그아웃")
                                .font(.body1)
                                .foregroundColor(Color("error"))
                        }
                    }
                }
            }
        }
        .frame(height: height)
        .background(Color.white)
    }
}

struct LogoutAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        LogoutAlert(showPopup: $showPopup) {
            result in
            print("결과에 따라 처리")
        }
    }
}
