//
//  PopupCategoryView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/21.
//

import SwiftUI

struct PopupCategoryView: View {
    @EnvironmentObject var viewModel: ChangeWorkCategoryViewModel
    @Binding var showPopup:Bool
    var categoryAddNotChange:Bool
    var originalCategory: CategoryModel?
    
    @State var inputCategoryText:String = ""
    @State var isSelected: CategoryColor = .first
    let colors: [CategoryColor] = [.first, .second, .third, .fourth, .fifth, .sixth, .seventh]
    
    var body: some View {
        VStack(spacing:30){
            BasicTextFiled(label: "카테고리명 입력", placeHolder: "카테고리명을 입력해주세요", inputText: $inputCategoryText, checkRed: false)
            
            colorPaletteCategory
            
            HStack(spacing:11) {
                Button {
                    if categoryAddNotChange {
                        viewModel.addCategoryList(name: inputCategoryText, color: isSelected)
                    } else {
                        guard let original = originalCategory else {return}
                        viewModel.changeCategoryList(id: original.id, name: inputCategoryText, color: isSelected) 
                    }
                    
                    showPopup.toggle()
                } label: {
                    BasicButtonLabel(text: "저장")
                }
                Button {
                    showPopup.toggle()
                } label: {
                    CancelButtonLabel()
                }
                    
            }
        }
        .padding(.horizontal, 20)
    }
    
    var colorPaletteCategory:some View {
        VStack(spacing:8) {
            HStack{
                Text("카테고리 색깔")
                    .font(.body3)
                Spacer()
            }
            
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Rectangle()
                            .frame(width: 5)
                            .foregroundColor(.clear)

                        
                        ForEach(colors, id: \.self) { color in
                            CategoryCircleColor(isSelected: $isSelected, myColor: color)
                        }
                        .onTapGesture {
                            print("Text tapped")
                        }
                        
                        Rectangle()
                            .frame(width: 5)
                            .foregroundColor(.clear)

                    }

                }
                .font(.body3)
                .frame(height: 86)
                .foregroundColor(Color("line2"))
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("line2"), lineWidth: 1)
                )
        }
    }
}

struct PopupCategoryView_Previews: PreviewProvider {
    @State static var showPopup = false
    @State static var isSelected: CategoryColor = .first
    static var previews: some View {
        PopupCategoryView(showPopup: $showPopup, categoryAddNotChange: false)
            .environmentObject(ChangeWorkCategoryViewModel())
    }
}
