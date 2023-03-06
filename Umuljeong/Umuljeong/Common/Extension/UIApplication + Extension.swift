//
//  UIApplication + Extension.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/24.
//

import UIKit
import SwiftUI

//extension UIApplication {
//    func endEditing() {
//        if UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.isFirstResponder == true {
//            sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }
//    }
//}

 
extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

