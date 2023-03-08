//
//  TimeOverAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import SwiftUI

struct TimeOverAlert: View {
    @Binding var showPopup:Bool
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 5){
                Text("유효 시간이 만료되었습니다.")
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

struct TimeOverAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        TimeOverAlert(showPopup: $showPopup)
    }
}
