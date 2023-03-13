//
//  ChangeWorkCategoryViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/22.
//

import Foundation

class ChangeWorkCategoryViewModel:ObservableObject {
    @Published var categoryList: [CategoryModel] = []
//    @Published var isSelected: CategoryColor = .first
    
    let allRepository = CategoryAllRepository()
    let addRepository = CategoryAddRepository()
    let removeRepository = CategoryRemoveRepository()
    let fixRepository = CategoryFixRepository()
    
    
    func requestAllCategory(reqResult : @escaping (Bool) -> ()) {
        allRepository.requestCategoryAll { result in
            switch result {
            case .success(let categoryList):
                guard let categoryList = categoryList else {return reqResult(false)}
                self.categoryList = categoryList.map{CategoryModel(id: $0.taskCategoryId, catogoryName: $0.name, categoryColor: $0.color.uppercased().checkColorCategory())}
                reqResult(true)
            case .failure:
                reqResult(false)
            }
        }
    }
    
    func changeCategoryList(id: Int, name: String, color: CategoryColor) {
        fixRepository.requestCategoryFix(taskCategoryDto: TaskCategoryDtoList(taskCategoryId: id, name: name, color: color.rawValue)) { result in
            switch result {
            case .success(_): self.requestAllCategory { result in
                
            }
            case .failure(_): break
            }
        }
//        let newCategory = CategoryModel(catogoryName: changeName, categoryColor: changeColor)
//        categoryList.indices.filter{categoryList[$0].catogoryName == originalName && categoryList[$0].categoryColor == originalColor}.forEach{ categoryList[$0] = newCategory}
//        print(categoryList)
    }
    
    func addCategoryList(name: String, color: CategoryColor) {
        addRepository.requestCategoryAdd(categoryInfo: CategoryInfo(name: name, color: color.rawValue)) { result in
            switch result {
            case .success(_): self.requestAllCategory { result in
                
            }
            case .failure(_): break
            }
        }
    }
    
    func deletCategoryList(idList: [Int]) {
        removeRepository.requestCategoryRemove(taskCategoryIdList: idList) { result in
            print("삭제 왜 적용이 안돼!")
            print(result)
            switch result {
            case .success(_): self.requestAllCategory { result in
                
            }
            case .failure(_): break
            }
        }
//        deleteCategory.forEach { deleteCategory in
//            guard let index = categoryList.firstIndex(of: deleteCategory) else {return}
//            categoryList.remove(at: index)
    }
}
