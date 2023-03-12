//
//  TokenErrorAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/10.
//

import SwiftUI

struct TokenErrorAlert: View {
    var message:String = "로그인 기간이 만료되었습니다."
    @Binding var showPopup:Bool
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 5){
                Text(message)
                Text("다시 로그인해주세요.")
            }
            .frame(height: 104)
            .font(.body2)
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
                                .font(.body1)
                        }
                    }
                }
            }
        }
        .background(Color.white)
    }
}

struct TokenErrorAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        TokenErrorAlert(showPopup: $showPopup)
    }
}
