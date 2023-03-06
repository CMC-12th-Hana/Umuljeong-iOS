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
    @Binding var viewModel:CalendarViewModel
    
    var teskList:[TeskModel] = [TeskModel(work: "디지털코리아 전용 회선", customer: "디지털 코리아", category: "문의"), TeskModel(work: "복실이 랜드", customer: "복실공주", category: "간식이 좋아")]
    
    var body: some View {
        VStack(spacing: 20){
            
            if isLeader {
                HStack(spacing: 10) {
                    Spacer()
                    Toggle(
                        isOn: $toggleIsOn) {
                            Text("구성원 업무보기")
                                .font(.body3)
                                .foregroundColor(Color("font2"))
                        } //: Toggle
                        .toggleStyle(MyToggleStyle())
                }
            }
            
            
            NavigationLink {
                AddTaskView(selecteDate: viewModel.getDate())
            } label: {
                PlusButtonLabel(label: "업무 추가하기")
            }
            
            if teskList.isEmpty {
                VStack{
                    Text("표시할 목록이 없습니다").font(.custom("Pretendard Medium", size: 14))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                VStack(spacing: 0){
                    if toggleIsOn {
                        MemberTaskCategoryDropDown(memberInfo: MemberSummaryModel(name: "박보노", isLeader: false), taskCount: 3)
                    } else {
                        //                    ScrollView{
                        ForEach(teskList) { task in
                            NavigationLink {
                                DetailTaskView()
                            } label: {
                                TaskWithCategoryCell(taskTitle: task.work, categoryName: task.category, categoryColor: .second, height: 72)
                                    .frame(height: 72)
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
//        .background(
//        Color("bg3")
//        )
    }
}

struct TeskListView_Previews: PreviewProvider {
    @State static var viewModel = CalendarViewModel()
    static var previews: some View {
        TaskListView(isLeader: true, viewModel: $viewModel)
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
