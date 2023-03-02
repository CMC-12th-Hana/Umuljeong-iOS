//
//  ChangeWorkCategoryViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/22.
//

import Foundation

class ChangeWorkCategoryViewModel:ObservableObject {
    @Published var categoryList: [CategoryModel] = [CategoryModel(catogoryName: "A/S", categoryColor: .first), CategoryModel(catogoryName: "단순문의", categoryColor: .second)]
    @Published var isSelected: CategoryColor = .first
    
    func changeCategoryList(originalName: String, changeName: String, originalColor: CategoryColor, changeColor: CategoryColor) {
        let newCategory = CategoryModel(catogoryName: changeName, categoryColor: changeColor)
        categoryList.indices.filter{categoryList[$0].catogoryName == originalName && categoryList[$0].categoryColor == originalColor}.forEach{ categoryList[$0] = newCategory}
        print(categoryList)
    }
    
    func addCategoryList(newCategoryName: String, newColor: CategoryColor) {
        categoryList.append(CategoryModel(catogoryName: newCategoryName, categoryColor: newColor))
    }
    
    func deletCategoryList(deleteCategory: [CategoryModel]) {
        deleteCategory.forEach { deleteCategory in
            guard let index = categoryList.firstIndex(of: deleteCategory) else {return}
            categoryList.remove(at: index)
        }
    }
}
