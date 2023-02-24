//
//  ChangeButtonBackgroundColor.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct ChangeButtonBackgroundColor: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color("bg3") : .white)
            .foregroundColor(configuration.isPressed ? Color("font1") : Color("font2"))
    }
}
