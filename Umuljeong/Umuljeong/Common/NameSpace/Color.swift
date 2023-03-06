//
//  Color.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/17.
//

import SwiftUI

//public enum Color {
//    public static let darkMint = UIColor(named: "dark_mint_main")!
//}


enum CategoryColor {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
}

func setCategoryColor(_ color: CategoryColor) -> Color {
    switch color {
    case .first:
        return Color("category1")
    case .second:
        return Color("category2")
    case .third:
        return Color("category3")
    case .fourth:
        return Color("category4")
    case .fifth:
        return Color("category5")
    case .sixth:
        return Color("category6")
    case .seventh:
        return Color("category7")
    }
}



