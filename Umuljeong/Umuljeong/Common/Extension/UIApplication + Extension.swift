//
//  UIApplication + Extension.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        if UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.isFirstResponder == true {
            sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
