//
//  GalleryImagesService.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/25.
//

import Foundation

class GalleryImagesService {
    
    func getGalleryImages() -> [Images] {
        PHPhotoLibrary.requestAuthorization{ (status) in
            if status == .authorized{
                self.getAllImages()
                self.disabled = false
                viewModel.testBinding()
            } else {
                print("not authorized")
                self.disabled = true
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}
