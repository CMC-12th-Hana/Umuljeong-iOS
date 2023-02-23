//
//  AddTaskView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/23.
//

import SwiftUI

struct AddTaskView: View {
    let selecteDate:Date
    
    var body: some View {
        ScrollView{
            searchCustomer
            searchBusiness
            selecteTask
            taskDateLabel
        }
        .defaultAppStyleHorizentalPadding()
        .navigationDesignDefault(title: "업무 추가하기")
    }
    
    var searchCustomer: some View {
        NavigationLink {
            SearhView()
        } label: {
            AddButtonLabel(label: "고객사명")
        }
    }
    
    var searchBusiness: some View {
        NavigationLink {
            SearhView()
        } label: {
            AddButtonLabel(label: "사업명")
        }
    }
    
    var selecteTask: some View {
        NavigationLink {
            SearhView()
        } label: {
            AddButtonLabel(label: "업무분류")
        }
    }

    var taskDateLabel:some View {
        VStack(spacing:0){
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
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("line2"), lineWidth: 1)
            )
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(selecteDate: Date())
    }
}
