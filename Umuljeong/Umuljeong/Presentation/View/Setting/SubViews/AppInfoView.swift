//
//  AppInfoView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/14.
//

import SwiftUI

struct AppInfoView: View {
    @State private var showPopover = false
    var body: some View {
        Button("Show Popover") {
            self.showPopover = true
        }
        .popover(isPresented: $showPopover, arrowEdge: .trailing) {
            Text("This is a popover view!")
                .font(.headline)
                .frame(width: 200, height: 200)
        }
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}
