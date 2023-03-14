//
//  BlueLable.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/13.
//

import SwiftUI

struct BlueLable: View {
    var width: CGFloat = 58
    var height: CGFloat = 20
    var text:String = "사업기간"
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 2)
                .fill(Color("main"))
                .frame(width: width, height: height)
            Text(text)
                .foregroundColor(Color.white)
                .font(.special1)
        }
    }
}

struct BlueLable_Previews: PreviewProvider {
    static var previews: some View {
        BlueLable()
    }
}
