//
//  MemberTaskCategoryDorpDown.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import SwiftUI

struct MemberTaskCategoryDropDown: View {
    let memberInfo: MemberSummaryModel
    let taskCount: Int
    @State var taskList: [TaskDtoList] = []
    @State private var shouldShowDropdown = false
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                dropDownBar
                if shouldShowDropdown {
                    dropDown
                        .padding(.horizontal, 4)
                }
            }
        }
        .background(
            Group {
                if shouldShowDropdown {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.white)
                        .shadow(radius: 1.2)
                } else {
                    Color.clear
                }
            }
        )
    }
    
    var dropDownBar:some View {
        ZStack {
            HStack(spacing:10){
                profileCircle
                memberName
                if memberInfo.isLeader {
                    LeaderLabel(width: 30, height: 17)
                }
                Spacer()
                memberCount
                    .padding(.trailing, 5)
                Button {
                    shouldShowDropdown.toggle()
                } label: {
                    ArrowImage
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 70)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
                    .frame(height: 70)
            )
        }
    }
    
    var dropDown:some View {
        VStack(spacing: 0){
            ForEach(taskList, id: \.taskId) { task in
                NavigationLink {
                    
                } label: {
                    TaskWithCategoryCell(taskTitle: task.title, categoryName: task.taskCategory, categoryColor: task.taskCategoryColor.checkColorCategory())
                }
            }
            
//            TaskWithCategoryCell(taskTitle: "울랄라 일정 수행", categoryName: "A/S", categoryColor: .second)
//            TaskWithCategoryCell(taskTitle: "저도 절 잘 몰라용", categoryName: "문의", categoryColor: .seventh)
        }
        .padding(.bottom, 15)

    }
    
    var profileCircle: some View {
        ZStack {
            Circle()
                .fill(Color("bg2"))
                .frame(width: 28, height: 28)
            Rectangle()
                .fill(Color.clear)
                .frame(width: 28, height: 28)
                .overlay(
                        Image("defaultUser")
                            .resizable()
                            .aspectRatio(contentMode:.fit)
                            .frame(width: 20.81, height: 28.67)
                            .padding(.top, 5)
                    )
                .clipShape(Circle())
            
        }
    }
    
    var memberName:Text {
        Text(memberInfo.name)
            .font(.body2)
            .foregroundColor(Color("font1"))
    }
    
    var memberCount:Text {
        Text("\(taskCount)")
            .font(.body1)
            .foregroundColor(Color("main"))
    }
    
    var ArrowImage: some View {
        ImageBox(rectangleSize: 24, image: Image(self.shouldShowDropdown ? "upArrow" : "downArrow"))
            .transaction { transaction in
                transaction.animation = nil
            }
    }
    
}

struct MemberTaskCategoryDropDown_Previews: PreviewProvider {
    static var previews: some View {
        MemberTaskCategoryDropDown(memberInfo: MemberSummaryModel(name: "구성원 이름", isLeader: true), taskCount: 3)
    }
}

