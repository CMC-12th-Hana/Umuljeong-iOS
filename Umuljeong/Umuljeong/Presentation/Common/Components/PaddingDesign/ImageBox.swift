//
//  ImageBox.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct ImageBox: View {
    let rectangleSize:CGFloat
    let image:Image
    var body: some View {
        ZStack{
            image
        }
        .frame(width: rectangleSize, height: rectangleSize)
    }
}

struct ImageBox_Previews: PreviewProvider {
    static var previews: some View {
        ImageBox(rectangleSize: 24, image: Image("rightArrow"))
    }
}
