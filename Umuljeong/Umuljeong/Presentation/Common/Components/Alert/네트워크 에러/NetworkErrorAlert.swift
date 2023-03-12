//
//  NetworkErrorAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/09.
//

import SwiftUI

struct NetworkErrorAlert: View {
    var message:String = "네트워크 연결 상태가 좋지 않습니다."
    @Binding var showPopup:Bool
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 5){
                Text(message)
                Text("잠시 후 다시 시도해주세요.")
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

struct NetworkErrorAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        NetworkErrorAlert(showPopup: $showPopup)
    }
}
