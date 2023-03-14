//
//  TaskRes.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/14.
//

import Foundation

// MARK: - TaskRes : taskId 통한 단순 업무 조회
struct TaskResponse: Codable {
    let taskId, memberId: Int
    let businessName, clientName, title, taskCategory: String
    let taskCategoryColor, description, date: String
    let taskImageDtoList: [TaskImageDtoList]
}

struct TaskImageDtoList: Codable {
    let taskImageId: Int
    let url: String
}

// MARK: - MemberTaskRes : MEMBER 메인화면 업무 목록 조회
struct TaskTaskResponse: Codable {
    let count: Int
    let taskDtoList: [TaskDtoList]
}

struct TaskDtoList: Codable {
    let taskId, memberId: Int
    let businessName, clientName, title, taskCategory: String
    let taskCategoryColor, description, date: String
    let taskImageDtoList: [TaskImageDtoList]
}

// MARK: - TaskListRes : TASK 메인화면 업무 목록 조회
struct MemberTaskResponse: Codable {
    let count: Int
    let memberDtoList: [MemberDtoTaskList]
}

struct MemberDtoTaskList: Codable {
    let name: String
    let taskDtoList: [TaskDtoList]
    let count: Int
}

struct MemberTaskList {
    let memberId:Int
    let memberName:String
    let taskCount: Int
    let taskDtoList: [TaskDtoList]
}


// MARK: - CreateTaskRes : 필요 X

// MARK: - DeleteTaskRes : 필요 X

// MARK: - TaskStatisticRes : 누적 업무 건수 그래프 정보
struct TaskStatisticResponse: Codable {
    let taskStatisticDtoList: [TaskStatisticDtoList]
}

struct TaskStatisticDtoList: Codable {
    let name, color: String
    let count: Int
}







