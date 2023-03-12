//
//  RemoveClientAlert.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/12.
//

import SwiftUI

struct RemoveClientAlert: View {
    @Binding var showPopup:Bool
    var result:(Bool) -> ()
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 5){
                Text("고객사를 삭제하면 해당하는")
                Text("사업, 업무 보고가 모두 삭제됩니다.")
                Text("그래도 삭제하시겠습니까?")
            }
            .frame(height: 126)
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
                        }
                    }
                    
                    Divider()
                        .frame(height: 56)
                    
                    Button {
                        result(true)
                        showPopup.toggle()
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 56)
                            Text("삭제")
                                .font(.body1)
                                .foregroundColor(Color("error"))
                        }
                    }
                }
            }
        }
        .background(Color.white)
    }
}

struct RemoveClientAlert_Previews: PreviewProvider {
    @State static var showPopup = false
    static var previews: some View {
        RemoveClientAlert(showPopup: $showPopup) {
            result in
            print("결과에 따라 처리")
        }
    }
}
