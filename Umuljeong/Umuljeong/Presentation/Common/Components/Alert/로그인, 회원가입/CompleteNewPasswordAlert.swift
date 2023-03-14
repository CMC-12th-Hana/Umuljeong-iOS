//
//  CompleteNewPasswordAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/07.
//

import SwiftUI

struct CompleteNewPasswordAlert: View {
    @Binding var showPopup:Bool
    @Binding var returnLoginView:Bool
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 5){
                Text("비밀번호 변경이 완료되었습니다.")
            }
            .frame(height: 82)
            .font(.body2)
            VStack(spacing: 0){
                Divider()
                HStack(spacing:11) {
                    Button {
                        showPopup.toggle()
                        returnLoginView.toggle()
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

struct CompleteNewPasswordAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    @State static var returnLoginView:Bool = false
    static var previews: some View {
        CompleteNewPasswordAlert(showPopup: $showPopup, returnLoginView: $returnLoginView)
    }
}
