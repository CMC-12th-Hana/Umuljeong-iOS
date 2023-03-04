//
//  UmuljeongApp.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

@main
struct UmuljeongApp: App {
    var rep1 = SignupRepositoryImpl()
    var body: some Scene {
        WindowGroup {
//            MainTabView()
            SignupView()
                .onAppear{
                    
                }
        }
    }
}
