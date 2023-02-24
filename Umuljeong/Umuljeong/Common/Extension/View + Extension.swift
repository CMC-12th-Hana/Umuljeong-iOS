//
//  View + Extension.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/19.
//

import SwiftUI

// MARK: - popupNavigationView

extension View {
    func popupNavigationView<Content: View>(
        horizontalPadding: CGFloat = 40
        , show: Binding<Bool>,
        @ViewBuilder content: @escaping ()->Content)
    -> some View {
        return self
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .overlay {
            if show .wrappedValue {
                GeometryReader { proxy in
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    NavigationView {
                        content()
                    }
                    .frame(width: size.width - horizontalPadding,
                           height: size.height / 1.7,
                           alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
    }
}


// MARK: - SetNavigationStyle

extension View {
    func navigationDesignDefault(title:String) -> some View {
        self.modifier(NavigationDesign(title:title))
    }
    
    func navigationAddDividerLine() -> some View {
        self.modifier(NavigationAddDividerLine())
    }
    
    func navigationTitleFontDefault(title:String) -> some View {
        self.modifier(NavigationTitleFontModifier(title:title))
    }
    
    func navigationBarBackButtonImageDefault() -> some View {
        self.modifier(NavigationBarBackButtonImageModifier())
    }
}

struct NavigationDesign: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let title:String
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.body2)
                }
            }
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

struct NavigationAddDividerLine: ViewModifier {

    func body(content: Content) -> some View {
        content
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
    }
}


// MARK: - SetHorizentalPadding

extension View {
    func defaultAppStyleHorizentalPadding(horizontal: CGFloat = 15) -> some View {
        self.modifier(PaddingModifier(horizontal: horizontal))
    }
}

struct PaddingModifier: ViewModifier {
    let horizontal: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontal)
    }
}







