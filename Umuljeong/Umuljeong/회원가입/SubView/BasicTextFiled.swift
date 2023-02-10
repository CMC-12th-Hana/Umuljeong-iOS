//
//  BasicTextFiled.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import Foundation
import SwiftUI

struct BasicTextFiled: View {
    var label:String
    var placeHolder:String
    @Binding var inputText:String
    @State var placeHolderColor:Color = Color("line1")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 1) {
                Text(label)
                    .font(.custom("Pretendard-Regular", size: 16))
                Text("*")
                    .foregroundColor(Color("error"))
                    .font(.custom("Pretendard-Regular", size: 16))
            }
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(placeHolderColor)
                    .frame(width: 335, height: 46)

                TextField(placeHolder, text: $inputText, onEditingChanged: { onEditingChanged in
                    if !onEditingChanged {
                        placeHolderColor = Color("line1")
                    } else {
                        placeHolderColor = Color("font1")
                    }
                })
                    .font(.custom("Pretendard-Regular", size: 16))
                    .frame(width: 305, height: 46)
            }
        }
    }
}

struct BasicTextFiled_Previews: PreviewProvider {
    @State static var contentText: String = "안녕하세요"
    static var previews: some View {
        BasicTextFiled(label: "이룸", placeHolder: "이름을 입력하세요", inputText: $contentText)
    }
}
