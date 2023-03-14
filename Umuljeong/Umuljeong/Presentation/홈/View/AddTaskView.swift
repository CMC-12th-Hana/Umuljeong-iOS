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
                    taskTitleFieldView
                    
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
        .onAppear{
            viewModel.requestClientList()
            viewModel.requestCategoryList()
            viewModel.setDate(date: selecteDate)
        }
    }
    
    var searchCustomer: some View {
        (DropdownBar(paddingL: 16, placeholder: "고객사명", options: viewModel.clientOptions, onOptionSelected: { option in
            print("선택된 고객사 옵션이 뭔지 \(option))")
            viewModel.requestBusinessList(clientId: option.key)
            viewModel.setClient(Id: option.key)
        }))
            
    }
    
    var searchBusiness: some View {
        (DropdownBar(paddingL: 30, placeholder: "사업명", options: viewModel.businessOptions, onOptionSelected: { option in
            print("선택된 사업 옵션이 뭔지 \(option))")
            viewModel.setBusiness(Id: option.key)
        }))
    }
    
    var selecteTask: some View {
        (DropdownBar(paddingL: 16, placeholder: "업무분류", options: viewModel.categoryOptions, onOptionSelected: { option in
            print("선택된 카테고리 옵션이 뭔지 \(option))")
            viewModel.setCategory(Id: option.key)
            print("확인용 \(viewModel.idList)")
        }))
    }
    
    var taskTitleFieldView: some View {
            HStack {
                Text("제목")
                    .font(.body2)
                    .foregroundColor(Color("font1"))
                
                TextField("", text: $viewModel.titleText)
                    .font(.body2)
                    .padding(.leading, 44)
                    .foregroundColor(Color("font1"))
                    .frame(maxWidth: .infinity)
                
            }
        .padding(.horizontal, 15)
        .cornerRadius(6)
        .frame(height: 46)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("line2"), lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
        )
    }


    
    var reportTextField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1.0)
                .fill(Color("bg1"))
                .frame(height: 260)
            
            MultilineTextField(text: $viewModel.descriptionText, placeholder: "업무내용을 작성해주세요")
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
            viewModel.requestAddTask { result in
                switch result {
                case true:
                    print("업무 추가 성공")
                case false:
                    print("업무 추가 실패")
                }
            }
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
