//
//  AddTaskView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct AddTaskView: View {
    @StateObject var viewModel = AddTaskViewModel()
    @State var inputReportText:String = ""
    @State var selected: [UIImage] = []
    
    let selecteDate:Date

    let options: [DropdownOption] = [
        DropdownOption(key: UUID().uuidString, value: "단순문의"),
        DropdownOption(key: UUID().uuidString, value: "고객민원"),
        DropdownOption(key: UUID().uuidString, value: "A/S"),
        DropdownOption(key: UUID().uuidString, value: "기술컨설팅"),
        DropdownOption(key: UUID().uuidString, value: "사전점검"),
        DropdownOption(key: UUID().uuidString, value: "사전점검"),
        DropdownOption(key: UUID().uuidString, value: "사전점검"),
        DropdownOption(key: UUID().uuidString, value: "사전점검")
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 10){
                Spacer()
                    .frame(height: 20)
                Group{
                    searchCustomer
                        .zIndex(3)
                    searchBusiness
                        .zIndex(2)
                    selecteTask
                        .zIndex(1)
                }
                
                VStack(spacing: 0){
                    reportTextField
                        .padding(.bottom, 6)
                    taskDateLabel
                        .padding(.bottom, 20)
                    addPhotoButton
                }
                
                if !viewModel.selectedImages.isEmpty {
                    selectedImageStack
                } else {
                    Spacer()
                        .frame(height: 80)
                }
                saveTaskButton
            }
        }
        .defaultAppStyleHorizentalPadding()
        .navigationDesignDefault(title: "업무 추가하기")
    }
    
    var searchCustomer: some View {
        DropdownBar(placeholder: "고객사명", options: options)
    }
    
    var searchBusiness: some View {
        DropdownBar(placeholder: "사업명", options: options)
    }
    
    var selecteTask: some View {
        DropdownBar(placeholder: "업무분류", options: options)
    }


    
    var reportTextField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1.0)
                .fill(Color("bg1"))
                .frame(height: 260)
            
            MultilineTextField(text: $inputReportText, placeholder: "업무내용을 작성해주세요")
                .autocorrectionDisabled(true)
                .font(.body2)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .frame(height: 260)
        }
    }
    
    var taskDateLabel:some View {
        HStack(spacing: 6){
            Spacer()
            Text("작성일자")
                .foregroundColor(Color("font1"))
                .font(.body3)
            Text(CalendarDateFomatter.date.string(from: selecteDate))
                .foregroundColor(Color("font2"))
                .font(.body4)
        }
    }
    
    
    
    var addPhotoButton:some View {
        NavigationLink {
            CustomGalleryView()
                .environmentObject(viewModel)
        } label: {
            HStack{
                Spacer()
                ImageBox(rectangleSize: 24, image: Image("camera"))
                Text("사진 첨부하기")
                    .font(.body2)
                    .foregroundColor(Color("font1"))
                Spacer()
            }
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("bg2"))
            )
        }
    }
    
    var selectedImageStack:some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10){
                ForEach(viewModel.taskImages, id: \.self){ i in
                    Image(uiImage: i.image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(6)
                        .overlay(
                            Button(action: {
                                viewModel.removeTaskImage(galleryImage: i)
                            }, label: {
                                ImageBox(rectangleSize: 24, image: Image("deleteButton"))
                            })
                            , alignment: .topTrailing
                        )
                }
            }
        }
    }
    
    var saveTaskButton:some View {
        Button {
            
        } label: {
            BasicButtonLabel(text: "완료")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    @State static var inputReportText:String = ""
    
    static var previews: some View {
        AddTaskView(selecteDate: Date())
    }
}
