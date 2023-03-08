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
    var checkRed:Bool = true
    var isLabel:Bool = true
    @State var placeHolderColor:Color = Color("line2")
        
    var body: some View {
        VStack(spacing:0){
            if isLabel {
                HStack(spacing: 1) {
                    Text(label)
                        .font(.body3)
                    if checkRed {
                        Text("*")
                            .foregroundColor(Color("error"))
                            .font(.body3)
                    }
                    Spacer()
                }
                .padding(.bottom, 8)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1.0)
                    .fill(placeHolderColor)
                
                TextField(placeHolder, text: $inputText, onEditingChanged: { onEditingChanged in
                    if !onEditingChanged {
                        placeHolderColor = Color("line2")
                    } else {
                        placeHolderColor = Color("line1")
                    }
                })
                .padding(.leading, 15)
                .font(.body3)
                .foregroundColor(Color("font1"))
                
                
            }
            .frame(height: 46)
            
        }
    }
}

struct BasicTextFiled_Previews: PreviewProvider {
    @State static var contentText: String = ""
    static var previews: some View {
        BasicTextFiled(label: "이룸", placeHolder: "이름을 입력하세요", inputText: $contentText)
    }
}
