//
//  ChangeWorkCategoryView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/14.
//

import SwiftUI

struct ChangeWorkCategoryView: View {
    @ObservedObject var viewModel = ChangeWorkCategoryViewModel()
    @State var setDeleteCategoryState = false
    @State var addCategoryPopup = false
    @State var changeCategoryPopup = false
    @State var selectCategory:CategoryModel?
    @State var deleteCategoryList:[CategoryModel] = []

    var body: some View {
        VStack(spacing:0){
            if !setDeleteCategoryState {
                Button {
                    addCategoryPopup.toggle()
                } label: {
                    PlusButtonLabel(label: "카테고리 추가하기")
                }
                .padding(.bottom, 20)
            }
            
        ScrollView {
            ForEach(viewModel.categoryList) { category in
                if setDeleteCategoryState {
                    CategoryDeleteOptionCell(category: category.catogoryName, categoryColor: category.categoryColor)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    if deleteCategoryList.contains(category) {
                                        guard let index = deleteCategoryList.firstIndex(of: category) else {return}
                                        deleteCategoryList.remove(at: index)
                                    } else {
                                        deleteCategoryList.append(category)
                                    }
                                }
                        )
                    
                }
                else {
                    Button {
                        selectCategory = category
                        changeCategoryPopup.toggle()
                    } label: {
                        CategoryOptionCell(category: category.catogoryName, categoryColor: category.categoryColor)
                    }
                }
            }
        }
            
        if setDeleteCategoryState {
            Button {
                viewModel.deletCategoryList(deleteCategory: deleteCategoryList)
                withAnimation{
                    setDeleteCategoryState.toggle()
                }
            } label: {
                BasicButtonLabel(text: "삭제하기")
            }

            
            
        }

        }//: Vstack
        .padding(.top, 34)
        .padding(.horizontal, 15)
        .navigationBarItems(
            trailing: Button(action: {
                withAnimation { setDeleteCategoryState.toggle() }
            }, label: {
                Image("delete")
            }))
        
        .popupNavigationView(horizontalPadding: 30, show: $addCategoryPopup) {
            VStack {
                PopupCategoryView(showPopup: $addCategoryPopup, categoryAddNotChange: true)
                    .environmentObject(viewModel)
                    .padding(.top, 30)
                Spacer()
            }
        }
        .popupNavigationView(horizontalPadding: 30, show: $changeCategoryPopup) {
            VStack {
                PopupCategoryView(showPopup: $changeCategoryPopup, categoryAddNotChange: false, originalCategory: selectCategory, inputCategoryText: selectCategory?.catogoryName ?? "", isSelected: selectCategory?.categoryColor ?? .first)
                    .environmentObject(viewModel)
                    .padding(.top, 30)
                Spacer()
            }
        }
    }
}

struct ChangeWorkCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeWorkCategoryView()
    }
}
