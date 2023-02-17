//
//  SettingModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/12.
//

import Foundation
import SwiftUI

struct SettingModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let imageName: String
    let view: AnyView
}
