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


enum CategoryColor:String {
    case first = "D813A2"
    case second = "E71F2A"
    case third = "356DF8"
    case fourth = "108852"
    case fifth = "4B5390"
    case sixth = "FFAD0F"
    case seventh = "8F00FF"
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



