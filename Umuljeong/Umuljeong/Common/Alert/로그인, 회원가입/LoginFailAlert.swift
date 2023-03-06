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
        VStack {
            Text("로그인에 실패하였습니다 다시 하세염")
            HStack(spacing:11) {
                Button {
                    showPopup.toggle()
                } label: {
                    Text("확인")
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
