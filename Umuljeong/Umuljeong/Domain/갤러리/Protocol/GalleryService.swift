//
//  GalleryService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import Foundation
import Photos

protocol GalleryService {
    func fetchGalleryImages(selectedImages:[GalleryImage], page: Int, closure: @escaping (_ image: GalleryImage) -> (), completion: @escaping (_ state: PHAuthorizationStatus) -> ())
    
//    func getGalleryImages(closure: @escaping (_ images: [Images]) -> ())
    
}
