//
//  NetworkErrorAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/09.
//

import SwiftUI

struct NetworkErrorAlert: View {
    let message:String
    @Binding var showPopup:Bool
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 5){
                Text(message)
                Text("다시 시도해주세요.")
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
    }
}

struct NetworkErrorAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        NetworkErrorAlert(message: "통신 에러입니다.", showPopup: $showPopup)
    }
}
