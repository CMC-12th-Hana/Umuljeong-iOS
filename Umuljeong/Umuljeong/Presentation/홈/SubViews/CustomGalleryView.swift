//
//  CustomGalleryView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/24.
//

import SwiftUI
import Photos

struct CustomGalleryView: View {
    @EnvironmentObject var viewModel:AddTaskViewModel
    @State private var isShowingImagePicker = false
//    @Binding var selected: [UIImage]
    @State var data:[Images] = []
//    @State var grid: [Int] = []
    @State var disabled:Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 0) {
                    // 첫번째 셀은 따로 처리
                    Button(action: {
                        isShowingImagePicker = true
                    }) {
                        Rectangle()
                            .fill(Color("bg2"))
                            .overlay(
                                VStack{
                                    Image("camera")
                                    Text("사진찍기")
                                        .font(.body3)
                                        .foregroundColor(Color("font1"))
                                }
                            )
                    }
                    .frame(width: (UIScreen.main.bounds.width)/3, height: (UIScreen.main.bounds.width)/3)
                    
                    if !viewModel.galleryImages.isEmpty {
                            ForEach(viewModel.galleryImages, id: \.self) { photoData in
                                Card(data: photoData)
                                    .environmentObject(viewModel)
                        }
                        .frame(width: (UIScreen.main.bounds.width)/3, height: (UIScreen.main.bounds.width)/3)
                    }
                    else {
                        if self.disabled {
                            Text("Enable Storage Access In Settings")
                        } else {
                            Indicator()
                        }
                    }
                }
            }
            
            Button {
                viewModel.saveSelectedImages()
                presentationMode.wrappedValue.dismiss()
            } label: {
                BasicButtonLabel(text: "완료")
            }
            .defaultAppStyleHorizentalPadding()
            .disabled((viewModel.selectedImages.isEmpty))

            
        }
        .onAppear{
//            viewModel.fetchImage()
            viewModel.testNewFetch()
            viewModel.updateSelectedImagesFromtaskImages()
            
//            PHPhotoLibrary.requestAuthorization{ (status) in
//                if status == .authorized{
//                    self.getAllImages()
//                    self.disabled = false
//                    viewModel.fetchImage()
//
//                } else {
//                    print("not authorized")
//                    self.disabled = true
//                }
//            }
        }
    }
    
//    func getAllImages(){
//        let req = PHAsset.fetchAssets(with: .image, options: .none)
//
//        DispatchQueue.global(qos: .background).async {
//
//            req.enumerateObjects { (asset, _, _) in
//
//                let options = PHImageRequestOptions()
//                options.isSynchronous = true
//
//                PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
//
//                    let data1 = Images(image: image!, selected: false)
//
//                    self.data.append(data1)
//                }
//            }
////            if req.count == self.data.count{
////                self.getGrid()
////            }
//        }
//    }
    
//    func getGrid() {
//        for i in stride(from: 0, to: self.data.count, by: 3){
//            self.grid.append(i)
//        }
//    }

}

struct CustomGalleryView_Previews: PreviewProvider {
    @State static var selected: [UIImage] = []
    @State static var data:[Images] = []
    static var previews: some View {
        CustomGalleryView()
            .environmentObject(AddTaskViewModel())
    }
}

struct Images: Hashable {
    var image: UIImage
    var selected:Bool
}


struct Card: View {
    @State var data: GalleryImage //아이덴티파이어로만 구분하고, 저장해두게 수정하기
//    @State var selected: [UIImage]
    @EnvironmentObject var viewModel:AddTaskViewModel
    
    var body: some View {
        ZStack {
            Image(uiImage: self.data.image)
                .resizable()
                .frame(width: (UIScreen.main.bounds.width)/3, height: (UIScreen.main.bounds.width)/3)
                .padding(-10)
                .overlay(
                    ZStack {
                        if viewModel.checkImageSelected(galleryImage: data) {
                            Circle()
                                .foregroundColor(Color("main"))
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Text(viewModel.getOrderSelectedImage(galleryImage: data))
                                        .font(.body3)
                                        .foregroundColor(Color.white)
                                )
                        } else {
                            Circle()
                                .stroke(Color.white, lineWidth: 1.5)
                                .frame(width: 20, height: 20)
                        }
                    }
                    , alignment: .topTrailing
                )
        }
        .onTapGesture {
//            print(data.selected)
            print(viewModel.galleryImages[0].image)
            if !viewModel.checkImageSelected(galleryImage: data){
                viewModel.addSelected(galleryImage: data)
                
                
                
                print("이거 지금 선택 됌? \(viewModel.checkImageSelected(galleryImage: data))")
//                data.selected.toggle()
//                viewModel.toggleGalleryImageState(galleryImage: data)
//                print("data.selected: \(data.selected)")
//                self.data.selected = true
//                viewModel.addSelected(galleryImage: data)
//                self.selected.append(self.data.image)
            } else {
                viewModel.removeSelected(galleryImage: data)
                
                
                print("이거 지금 선택 됌? \(viewModel.checkImageSelected(galleryImage: data))")
//                data.selected.toggle()
//                if let index = selected.firstIndex(of: data.image) {
//                    selected.remove(at: index)
//                    self.data.selected = false
//                    viewModel.removeSelected(galleryImage: data)
//                }
            }
        }
    }
}

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    
}
