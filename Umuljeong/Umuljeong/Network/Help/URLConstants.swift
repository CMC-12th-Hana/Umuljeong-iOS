//
//  APIConstants.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/02.
//

import Foundation

struct URLConstants {
    // MARK: - Base URL
    static let baseURL = "http://fieldmate-env.eba-xwpp7hek.ap-northeast-2.elasticbeanstalk.com"
    static let baseCompanyURL = baseURL + "/company"
    static let baseCompanyMemberURL = baseCompanyURL + "/member"
    static let baseCompanyClientURL = baseCompanyURL + "/client"
    static let baseCompanyClientBusinessURL = baseCompanyClientURL + "/business"
    static let baseCompanyClientBusinessTaskURL = baseCompanyClientBusinessURL + "/task"
    
    
    // MARK: - Feature URL
    // MARK: - Auth : 로그인 / 회원가입
    static let Auth_Login = baseURL + "/login"
    static let Auth_Signup = baseURL + "/join"
    static let Auth_CompanyJoin = baseCompanyURL + "/join"
    
    // MARK: - Company : 회사 추가
    static let Company_Create = baseCompanyURL
    
    
    // MARK: - Task : 업무 조회 / 추가
    static let Task_Add = baseCompanyClientBusinessTaskURL
    
    static func Task_Detail(taskId: String) -> String {
        return baseCompanyClientBusinessTaskURL + "/\(taskId)"
    }
    static func Task_Remove(taskId: String) -> String {
        return baseCompanyClientBusinessTaskURL + "/\(taskId)"
    }
    static func Task_Main_All(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/client/business/tasks"
    }
    static func Task_Graph(clientId: String) -> String {
        return baseCompanyClientURL + "/\(clientId)" + "/business/task/statistic"
    }
    static func Task_Calendar_All(businessId: String) -> String {
        return baseCompanyClientBusinessURL + "/\(businessId)" + "/tasks"
    }
    
    
    
    // MARK: - TaskCategory : 업무 카테고리 조회 / 추가 / 수정 / 삭제
    static let TaskCategory_Remove = baseCompanyClientBusinessURL + "/task/categories"
    
    static func TaskCategory_All(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/client/business/task/categories"
    }
    static func TaskCategory_Add(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/client/business/task/category"
    }
    static func TaskCategory_Fix(categoryId: String) -> String {
        return baseCompanyClientBusinessURL + "/task/category" + "/\(categoryId)"
    }
    
    
    // MARK: - Client : 고객사 조회 / 추가 / 수정
    static func Client_Add(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/client"
    }
    static func Client_All(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/clients"
    }
    
    static func Client_Business_All(clientId: String) -> String {
        return baseCompanyClientURL + "/\(clientId)" + "/businesses"
    }
    
    static func Client_Detail(clientId: String) -> String {
        return baseCompanyClientURL + "/\(clientId)"
    }
    static func Client_Fix(clientId: String) -> String {
        return baseCompanyClientURL + "/\(clientId)"
    }
    
    static func Client_Remove(clientId: String) -> String {
        return baseCompanyClientURL + "/\(clientId)"
    }
    
    
    
    // MARK: - Business : 사업 조회 / 추가
    static func Business_Add(clientId: String) -> String {
        return baseCompanyClientURL + "/\(clientId)" + "/business"
    }
    
    static func Business_All(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/client/businesses"
    }
    
    static func Business_Detail(businessId: String) -> String {
        return baseCompanyClientBusinessURL + "/\(businessId)"
    }
    static func Business_Fix(businessId: String) -> String {
        return baseCompanyClientBusinessURL + "/\(businessId)"
    }
    
    
    
    
    // MARK: - Member : 사원 조회 / 추가
    static let Member_MyDetail = baseCompanyMemberURL + "/profile" //내꺼 조회
    
    static func Member_OtherDetail(memberId: String) -> String {
        return baseCompanyMemberURL + "/\(memberId)" + "/profile"
    }
    
    static func Member_Leader_Fix_OtherDetail(memberId: String) -> String {
        return baseCompanyMemberURL + "/\(memberId)" + "/profile"
    }
    
    
    static let Member_MyProfileFix = baseCompanyMemberURL + "/profile"
    
    static func Member_Add(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/member"
    }
    static func Member_All(companyId: String) -> String {
        return baseCompanyURL + "/\(companyId)" + "/members"
    }
    
    static func Member_Remove(memberId: String) -> String {
        return baseCompanyMemberURL + "/\(memberId)"
    }
}
