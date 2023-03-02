//
//  MultilineTextField.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/24.
//

import SwiftUI
import UIKit

struct MultilineTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField
        
        init(_ uiTextView: MultilineTextField) {
            self.parent = uiTextView
        }

        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = nil
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor(named: "font3")
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // 예상 단어를 삭제하는 경우
            textField.inputAssistantItem.leadingBarButtonGroups = []
            textField.inputAssistantItem.trailingBarButtonGroups = []
        
            return true
        }
    }
    
    @Binding var text: String
    var placeholder: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        textView.smartDashesType = .no
        textView.smartQuotesType = .no
        textView.smartInsertDeleteType = .no
        textView.spellCheckingType = .no
        textView.text = placeholder
        textView.font = .body2
        textView.textColor = UIColor(named: "font3")
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {

    }
    
    func makeCoordinator() -> MultilineTextField.Coordinator {
        return Coordinator(self)
    }
}


struct MultilineTextField_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        MultilineTextField(text: $text, placeholder: "dd")
    }
}
