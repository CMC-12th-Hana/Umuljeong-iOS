//
//  AddTaskViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import UIKit
import Photos

class AddTaskViewModel:ObservableObject {
    @Published var inputCustomerText:String = ""
    @Published var inputBusinessText:String = ""
    @Published var selectedTask:String = ""
    
    //새로 만들기
    @Published var taskImages: [GalleryImage] = []
    @Published var galleryImages: [GalleryImage] = []//AddView에 올라 갈 이미지 모음
    @Published var selectedImages: [GalleryImage] = []
    
    
//    @Published var galleryImages: [Images] = [] //갤러리에 깔아줄 때 바로바로 확인하기 위해서 Images Data 확인
    @Published var selectedUserImages: [UIImage] = [] //가져갈 때는 UIImage 형태로 가져가기
    //데이터 세팅할 때, 선택되어 있던 이미지를 걸러내는 코드 추가
    @Published var galleryDisabled:Bool?
    
    let service:GalleryImagesService = GalleryImagesService()
    
    var selectDate:String = ""
    
    var page:Int = 0
    
    func testNewFetch() {
        galleryImages = [] //추후 수정
        service.fetchGalleryImages(selectedImages: [], page: page) { image in
            if image.image == UIImage.init() {
                self.galleryDisabled = true
            } else {
                DispatchQueue.main.async {
                    self.galleryImages.append(image)
                }
            }
            
            print("테스트 이미지 받아오기 진행중 : 여러 번 호출되어야 함\(image)")
        } completion: { state in
            if state == .authorized {
                print("사진 로딩 해도 됌")
                self.page += 1
            } else {
                print("사용자에게 경고창 출력")
            }
        } //수정해야 됌.
    }
    
    func saveSelectedImages() {
        taskImages = selectedImages
        print("추가 됐는 지 확인합니당 taskImages : \(taskImages)")
    }
    
    func updateSelectedImagesFromtaskImages() {
        selectedImages = taskImages
    }
    
    //선택된 갤러리 이미지 유저 이미지에 추가 func
    func addSelected(galleryImage: GalleryImage){
        guard selectedImages.count <= 10 else {return}
        selectedImages.append(galleryImage)
    }
    
    //CustomGallery에서 선택된 유저 이미지 유저 이미지에서 삭제
    func removeSelected(galleryImage: GalleryImage){
        guard let selectedIndex = selectedImages.map({$0.localIdentifier}).firstIndex(of: galleryImage.localIdentifier) else {return}
        selectedImages.remove(at: selectedIndex)
    }
    
    func removeTaskImage(galleryImage: GalleryImage) {
        guard let index = taskImages.map({$0.localIdentifier}).firstIndex(of: galleryImage.localIdentifier) else {return}
        taskImages.remove(at: index)
    }
    
    func getOrderSelectedImage(galleryImage: GalleryImage) -> String {
        guard let selectedIndex = selectedImages.map({$0.localIdentifier}).firstIndex(of: galleryImage.localIdentifier) else {return ""}
        return String(selectedIndex + 1)
        
    }
    
    func selectedImagesEmpty() -> Bool {
        return selectedUserImages.isEmpty
    }
    
    func checkImageSelected(galleryImage: GalleryImage) -> Bool {
        return selectedImages.map{$0.localIdentifier}.contains(galleryImage.localIdentifier)
    }
    
    //갤러리 이미지 상태 변경 (버튼에 반영 될 정보)
//    func toggleGalleryImageState(galleryImage: Images){
//        print("galleryImageFirst: \(galleryImages[0])")
//
//        guard let galleryIndex = galleryImages.firstIndex(of: galleryImage) else {return}
//        print("galleryIndex: \(galleryIndex)")
//        galleryImages[galleryIndex].selected.toggle()
//        print("galleryImages[galleryIndex].selected. : \(galleryImages[galleryIndex].selected)")
//        print(" selectedUserImages: \( selectedUserImages)")
//    }
    
    //선택된 유저 이미지 인덱스 번호 반환 func
    func getSelectedUserImageNumber(image: Images) -> String {
        let number = getSelectedUserImageIndex(image: image) + 1
        return "\(number)"
    }
    
    func getSelectedUserImageIndex(image: Images) -> Int {
        guard let index = selectedUserImages.firstIndex(of: image.image) else {return 0}
        return index
    }
    
    func getSelectedGalleryImageIndex(image: UIImage) -> Int {
        guard let index = galleryImages.map({$0.image}).firstIndex(of: image) else {return 0}
        return index
    }
    
    func getImageSelectedState(galleryImage: UIImage) -> Bool {
//        return galleryImages[getSelectedGalleryImageIndex(image: galleryImage)].selected
        return false
    }
    
    func testBinding() {
        print("잘 연결 돼 있슈")
    }
    
}



