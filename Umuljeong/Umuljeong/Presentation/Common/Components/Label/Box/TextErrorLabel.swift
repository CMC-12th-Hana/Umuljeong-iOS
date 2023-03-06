//
//  TextErrorLabel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import Foundation
import SwiftUI

struct textErrorLabel: View {
    let label:String

    var body: some View {
        HStack {
            if label != "" {
                Image("redX")
                Text(label)
                    .foregroundColor(Color("error"))
                    .font(.body5)
                Spacer()
            }
        }
    }
}

