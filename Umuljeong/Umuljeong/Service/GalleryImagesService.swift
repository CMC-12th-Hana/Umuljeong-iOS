//
//  GalleryImagesService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/25.
//

import UIKit
import Photos

struct GalleryImage: Hashable {
    var image: UIImage
    var localIdentifier: String
    var isSelected: Bool
}


class GalleryImagesService {
 
    func fetchGalleryImages(selectedImages:[GalleryImage], page: Int, closure: @escaping (_ image: GalleryImage) -> (), completion: @escaping (_ state: PHAuthorizationStatus) -> ()) {
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        var images: [GalleryImage] = []
        var selectedIdentifiers: Set<String> = [] // 선택된 이미지의 localIdentifier 값을 저장할 배열

        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                let startIndex = (page - 1) * 20
                let endIndex = min(startIndex + 20, req.count)
                
                if startIndex >= images.count {
                    // 이미지를 모두 로드한 경우 이미지를 다시 불러오지 않음
                    completion(.authorized)
                    return
                }

                req.enumerateObjects({ (asset, index, stop) in
                    if index < 20 { // 최대 20개의 이미지만 로드
                        let requestOptions = PHImageRequestOptions()
                        requestOptions.isSynchronous = true //동기식으로 처리하는 지

                        PHImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: requestOptions) { (image, info) in
                            if let image = image {
                                let imageData = GalleryImage(image: image, localIdentifier: asset.localIdentifier, isSelected: selectedIdentifiers.contains(asset.localIdentifier)) // 배열에 이미지의 localIdentifier가 있는 경우, 선택된 이미지로 설정
                                DispatchQueue.main.async {
                                    closure(imageData)
                                }
                            }

                            if images.count == (endIndex - startIndex) {
                                completion(.authorized)
                            }
                        }

                        // 이미지가 선택되었는지 확인하여, selectedIdentifiers 배열에 추가
                        if let selectedAsset = selectedImages.first(where: { $0.localIdentifier == asset.localIdentifier }) {
                            selectedIdentifiers.insert(selectedAsset.localIdentifier)
                        }
                    } else {
                        stop.pointee = true
                    }
                })
            } else {
                closure(GalleryImage(image: .init(), localIdentifier: "", isSelected: false))
                completion(.denied)
            }
        }
    }

    
//    func getGalleryImages(closure: @escaping (_ images: [Images]) -> ()) {
//        let req = PHAsset.fetchAssets(with: .image, options: .none)
//        var returnImages:[Images] = []
//
//        PHPhotoLibrary.requestAuthorization{ (status) in
//            if status == .authorized{
//                DispatchQueue.global(qos: .background).async {
//
//                    req.enumerateObjects { (asset, _, _) in
//
//                        let options = PHImageRequestOptions()
//                        options.isSynchronous = true
//                        
//                        PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
//
//                            let imageData = Images(image: image!, selected: false)
//
//                            returnImages.append(imageData)
//                        }
//                    } //grid 관련 삭제함 : 혹시 몰라 남겨둠 추후 이 주석 삭제
//                    closure(returnImages)
//                }
//            } else {
//                print("not authorized")
//
//                // MARK: - 카메라 기능 비활성화 시 처리 로직 작성
//                //빈 배열이면 disabled true
////                closure([])
//            }
//        }
//    }
}
