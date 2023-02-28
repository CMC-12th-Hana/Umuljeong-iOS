//
//  photoCell.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/25.
//

import SwiftUI

//선택 되었을 때 순서 적용
//선택 취소되었을 때 체크 표시 해제

struct photoCell: View {
    @State var selected:Bool = true
    var body: some View {
        Image("sampleImage")
            .resizable()
            .frame(width: 125, height: 125)
            .overlay(
                ImageBox(rectangleSize: 24, image: Image("deleteButton"))
                , alignment: .topTrailing
            )
    }
}

struct photoCell_Previews: PreviewProvider {
    static var previews: some View {
        photoCell()
    }
}
