//
//  GrayLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct GrayLabel: View {
    var width: CGFloat = 48
    var height: CGFloat = 20
    var text:String = "매출액"
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 2)
                .stroke(Color("line2"), lineWidth: 1)
                .frame(width: width, height: height)
            Text(text)
                .foregroundColor(Color("main"))
                .font(.special1)
        }
    }
}

struct GrayLabel_Previews: PreviewProvider {
    static var previews: some View {
        GrayLabel()
    }
}
