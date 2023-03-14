//
//  TaskListView.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/16.
//

import SwiftUI

struct TaskListView: View {
    let isLeader:Bool
    @State var toggleIsOn: Bool = false
    @EnvironmentObject var viewModel:MainTaskViewModel
    
    var body: some View {
        VStack(spacing: 20){
            if isLeader == true {
                HStack(spacing: 10) {
                    Spacer()
                    Toggle(
                        isOn: $toggleIsOn) {
                            Text("구성원 업무보기")
                                .font(.body3)
                                .foregroundColor(Color("font2"))
                        }
                        .toggleStyle(MyToggleStyle())
                }
            }
            
            if viewModel.taskFeedList.isEmpty {
                VStack{
                    Text("표시할 목록이 없습니다")
                        .font(.custom("Pretendard Medium", size: 14))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            else {
                VStack(spacing: 0){
                    if toggleIsOn {
                        ForEach(viewModel.taskMemberFeedList, id:\.memberId) { task in
                            MemberTaskCategoryDropDown(memberInfo: MemberSummaryModel(name: task.memberName, isLeader:false), taskCount: task.taskCount, taskList: task.taskDtoList)
                        }
                        
                        
                    } else {
                        NavigationLink {
                            AddTaskView(selecteDate: viewModel.getDate())
                        } label: {
                            PlusButtonLabel(label: "업무 추가하기")
                        }
                        .padding(.bottom, 10)
                        ForEach(viewModel.taskFeedList, id:\.taskId) { task in
                            NavigationLink {
                                DetailTaskView()
                            } label: {
                                TaskWithCategoryCell(taskTitle: task.title, categoryName: task.taskCategory, categoryColor: task.taskCategory.checkColorCategory())
                            }
                        } // : ForEach
                        .padding(.bottom, 10)
//                        .padding(., 10)
                    }
//                    } // : ScrollView
                }
                .transaction { transaction in
                    transaction.animation = nil
                }
            }
        }
        .padding(.top, 20)
        .defaultAppStyleHorizentalPadding()
    }
}

struct TeskListView_Previews: PreviewProvider {
    @State static var viewModel = MainTaskViewModel()
    static var previews: some View {
        TaskListView(isLeader: true)
            .environmentObject(MainTaskViewModel())
    }
}

struct MyToggleStyle: ToggleStyle {
    private let width = 40.0
    private let height = 22.0
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      ZStack(alignment: configuration.isOn ? .trailing : .leading) {
        RoundedRectangle(cornerRadius: 12)
          .frame(width: width, height: height)
          .foregroundColor(configuration.isOn ? Color("main") : Color("bg1"))

        Circle()
          .frame(width: 15)
          .padding(4)
          .foregroundColor(.white)
          .onTapGesture {
            withAnimation {
              configuration.$isOn.wrappedValue.toggle()
            }
          }
      }
    }
  }
}
