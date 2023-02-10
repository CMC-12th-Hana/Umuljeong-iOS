//
//  ContentView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Vector")
                .resizable()
                .frame(width: 60, height: 61.3)
            Text("Hello, world!")
                .font(.custom("Pretendard-Regular", size: 40))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
