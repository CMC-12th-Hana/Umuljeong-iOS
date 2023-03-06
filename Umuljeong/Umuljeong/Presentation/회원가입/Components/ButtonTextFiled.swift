//
//  ButtonTextFiled.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import SwiftUI

struct ButtonTextFiled: View {
    @Binding var inputText:String
    @Binding var errorMessage: String?
    let textFiledStyle: TextFiledStyle
    let onTapGesture: Bool?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text("휴대폰 번호")
                Text("*")
                    .foregroundColor(Color("error"))
            }
            .font(.body3)
            
            HStack(alignment: .firstTextBaseline, spacing: 7.75) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1.0)
                        .fill(roundRectangleColorChange())
                    
                    TextField("휴대폰 번호를 입력해주세요", text: $inputText)
                        .padding(15)
                        .font(.body3)
                }
                .frame(height: 46)
                
                Button {
                    print("")
                } label: {
                    Text("인증번호 받기")
                        .font(.special4)
                        .foregroundColor(Color("line2"))
                        .padding(13)
                        .frame(height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("line2"), lineWidth: 1)
                        )
                }
            }
        }
    }

    
    func roundRectangleColorChange() -> Color {
        guard let onTap = onTapGesture else {return Color("line2")}
        
        if onTap {
            return Color("line1")
        } else {
            if inputText != "" && errorMessage != nil {
                return Color("error")
            }
            return Color("line2")
        }
    }
}

struct ButtonTextFiled_Previews: PreviewProvider {
    @State static var contentText: String = ""
    @State static var text: String?
    static var previews: some View {
        ButtonTextFiled(inputText: $contentText, errorMessage: $text, textFiledStyle: .email, onTapGesture: nil)
    }
}
