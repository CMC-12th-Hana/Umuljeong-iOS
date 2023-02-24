//
//  CustomGalleryView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/24.
//

import SwiftUI
import Photos

struct CustomGalleryView: View {
    @State private var isShowingImagePicker = false
    @Binding var selected: [UIImage]
    @State var data:[Images] = []
    @State var grid: [Int] = []
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
                    
                    if !self.grid.isEmpty{
                        ForEach(self.data, id: \.self) { photoData in
                            Card(data: photoData, selected: self.$selected)
                        }
                    }
                    else {
                        if self.disabled{
                            Text("Enable Storage Access In Settings")
                        } else {
                            Indicator()
                        }
                    }
                }
            }
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                BasicButtonLabel(text: "완료")
            }
            .defaultAppStyleHorizentalPadding()
            .disabled((self.selected.count != 0) ? false : true)

            
        }
        .onAppear{
            PHPhotoLibrary.requestAuthorization{ (status) in
                if status == .authorized{
                    self.getAllImages()
                    self.disabled = false
                    
                } else {
                    print("not authorized")
                    self.disabled = true
                }
            }
            
        }
    }
    
    func getAllImages(){
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {
            
            req.enumerateObjects { (asset, _, _) in
                
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                    
                    let data1 = Images(image: image!, selected: false)
                    
                    self.data.append(data1)
                }
            }
            if req.count == self.data.count{
                self.getGrid()
            }
        }
    }
    
    func getGrid() {
        for i in stride(from: 0, to: self.data.count, by: 3){
            self.grid.append(i)
        }
    }
    
    
}

struct CustomGalleryView_Previews: PreviewProvider {
    @State static var selected: [UIImage] = []
    @State static var data:[Images] = []
    static var previews: some View {
        CustomGalleryView(selected: $selected)
    }
}

struct Images: Hashable {
    var image: UIImage
    var selected:Bool
}


struct Card: View {
    @State var data: Images
    @Binding var selected: [UIImage]
    
    var body: some View {
        ZStack {
            Image(uiImage: self.data.image)
                .resizable()
            
            if self.data.selected {
                
                ZStack {
                    
                    Color.black.opacity(0.5)
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.width)/3, height: (UIScreen.main.bounds.width)/3)
        .onTapGesture {
            if !self.data.selected{
                self.data.selected = true
                self.selected.append(self.data.image)
            } else {
                for i in 0..<self.selected.count {
                    if self.selected[i] == self.data.image {
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                }
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
