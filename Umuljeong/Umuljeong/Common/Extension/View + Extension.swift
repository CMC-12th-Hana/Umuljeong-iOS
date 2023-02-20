//
//  View + Extension.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

extension View {
    
    func navigationTitleFontDefault(title:String) -> some View {
        self.modifier(NavigationTitleFontModifier(title:title))
    }
    
    func navigationBarBackButtonImageDefault() -> some View {
        self.modifier(NavigationBarBackButtonImageModifier())
    }
}

struct NavigationBarBackButtonImageModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image("backButton")
                        }
                    })
    }
}

struct NavigationTitleFontModifier: ViewModifier {
    let title:String

    func body(content: Content) -> some View {
        content
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.body2)
            }
        }
    }
}







