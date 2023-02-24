//
//  AddTaskView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct AddTaskView: View {
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
        VStack(spacing: 8){
            Spacer()
                .frame(height: 20)
            Group{
                searchCustomer
                searchBusiness
                selecteTask
                    .zIndex(1)
                taskDateLabel
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
            reportTextField
            addPhotoButton
            
            if !self.selected.isEmpty {
                selectedImageStack
            } else {
                Spacer()
            }
        
            saveTaskButton
        }
        .defaultAppStyleHorizentalPadding()
        .navigationDesignDefault(title: "업무 추가하기")
    }
    
    var searchCustomer: some View {
        NavigationLink {
            SearhView(searchTopic: "고객사명")
        } label: {
            AddButtonLabel(label: "고객사명")
        }
    }
    
    var searchBusiness: some View {
        NavigationLink {
            SearhView(searchTopic: "사업명")
        } label: {
            AddButtonLabel(label: "사업명")
        }
    }
    
    var selecteTask: some View {
        DropdownBar(placeholder: "업무분류", options: options)
    }

    var taskDateLabel:some View {
        HStack(spacing: 10){
            Text("업무 일자")
                .foregroundColor(Color("font1"))
            Text(CalendarDateFomatter.date.string(from: selecteDate))
                .foregroundColor(Color("font2"))
            Spacer()
        }
        .font(.body2)
        .padding(.horizontal, 15)
        .frame(height: 46)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color("line2"), lineWidth: 1)
        )
    }
    
    var reportTextField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1.0)
                .fill(Color("bg1"))
                .frame(height: 260)
            
            MultilineTextField(text: $inputReportText, placeholder: "보고 내용을 작성해주세요")
                .autocorrectionDisabled(true)
                .font(.body2)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .frame(height: 260)
        }
    }
    
    var addPhotoButton:some View {
        NavigationLink {
            CustomGalleryView(selected: $selected)
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
            HStack(spacing: 20){
                ForEach(self.selected, id: \.self){ i in
                    Image(uiImage: i)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(6)
                    
                }
            }
            .defaultAppStyleHorizentalPadding()
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
