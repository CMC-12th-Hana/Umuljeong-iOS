//
//  UmuljeongApp.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/06.
//

import SwiftUI

@main
struct UmuljeongApp: App {
    var 회원가입 = SignupRepositoryImpl()
    var 로그인 = LoginRepository()
    var 회사생성 = CompanyCreateRepositoryImpl()
    var 회사합류하기 = CompanyJoinRepository()
    
    var 사업추가하기 = BusinessAddRepository()
    var 사업조회하기 = BusinessDetailRepository()
    var 사업수정하기 = BusinessFixRepository()
    
    var 멤버추가하기 = MemberAddRepository()
    var 멤버상세보기 = MemberMyDetailRepository()
    var 멤버수정하기 = MemberFixMyProfileRepository()
    var 멤버회사전체보기 = MemberAllRepository()
    
    var 고객사추가하기 = ClientAddRepository()
    var 고객사상세보기 = ClientDetailRepository()
    //    var 고객사수정하기 = ClientFixRepository()
    var 고객사전체보기 = ClientAllRepository()
    
    var 카테고리추가하기 = CategoryAddRepository()
    var 카테고리수정 = CategoryFixRepository()
    var 카테고리전체보기 = CategoryAllRepository()
    var 카테고리삭제하기 = CategoryRemoveRepository()
    
    var 내정보핸드폰에등록하기 = MemberUniqueInfoRepository()
    
    var body: some Scene {
        WindowGroup {
//            if ApiManager.shared.myLoginState() ?? false {
//                MainTabView()
//                    .onAppear{
//                        print(ApiManager.shared.myLoginState())
//                    }
//            } else {
                LoginView()
                .onAppear{
                    
//                    내정보핸드폰에등록하기.requestMyUniqueInfo { result in
//                        print(result)
//
//                    }
//                    ApiManager.shared.allInfoTokenReset()
                }
//            }
        }
    }
}
            
//            SignupView()
            
//                .onAppear{
//                    내정보핸드폰에등록하기.requestMyUniqueInfo { result in
//                        switch result {
//                        case .success(_):
//                            print("메서드 실행 완료 시점에서 확인")
//                            print(ApiManager.shared.myRole())
//                            print(ApiManager.shared.keychain.get("accessToken"))
//                        case .failure(_):
//                            print("메서드 실행 완료 시점에서 확인 : 실패함")
//                        }
//                    }
                    //회원가입 성공 -> 아이디, 토큰 받음
//                    회원가입.requestSignup(signupInfo: SignupInfo(name: "가나다", phoneNumber: "01011111111", password: "qweR!1234", passwordCheck: "qweR!1234")) { response in
//                        switch response {
//                        case .success:
//                            print("SignupViewModel : 회원가입 성공")
//                        default : print("SignupViewModel : 통신 실패")
//                        }
//                    }
                    //로그인 성공 -> 아이디 비번으로 토큰 받음 (앞으로도 계속 로그인 시도하며 토큰 발급)
//                    로그인.requestLogin(loginInfo: LoginInfo(phoneNumber: "01011111111", password: "qweR!1234")) { response in
//                        switch response {
//                        case .success:
//                            print("SignupViewModel : 로그인 성공")
//                        default : print("SignupViewModel : 통신 실패")
//                        }
//                    }
                    
//                    회사생성.requestCreateCompany(name: "주식회사혜운") { response in
//                        switch response {
//                        case .success:
//                            print("회사 생성 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("회사생성 통신 실패")
//                        }
//                    }
                    
                    // MARK: - 토큰 재발급 로직 들어있음 (엉터리 값 넣어줘서 이건 냅두고 테스트 진행)
//                    회사합류하기.requestCompanyJoin() { response in
//                        switch response {
//                        case .success:
//                            print("회사합류 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("회사합류 통신 실패")
//                        }
//                    }
                    
//                    사업추가하기.requestBusinessAdd(businessInfo: BusinessInfo(name: "어쩌구", businessPeriodDto: BusinessInfo.BusinessPeriodDto(start: "2023-03-04", finish: "2023-03-04"), memberIdList: [1], revenue: 0, description: "아뇨옹")) { response in
//                        switch response {
//                        case .success:
//                            print("사업추가하기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("사업추가하기 통신 실패")
//                    }
//                }
//
//                    사업조회하기.requestBusinessDetail() { response in
//                        switch response {
//                        case .success:
//                            print("사업조회하기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("사업조회하기 통신 실패")
//                    }
//                }
//
//                    사업수정하기.requestBusinessFix(businessInfo: BusinessInfo(name: "어쩌구", businessPeriodDto: BusinessInfo.BusinessPeriodDto(start: "2023-03-04", finish: "2023-03-04"), memberIdList: [1], revenue: 0, description: "아뇨옹")) { response in
//                        switch response {
//                        case .success:
//                            print("사업수정하기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("사업수정하기 통신 실패")
//                    }
//                }
//
//                    멤버추가하기.requestMemberAdd(memberInfo: MemberInfo(name: "보노보", phoneNumber: "01011111111", staffRank: "대리", staffNumber: "123")) { response in
//                        switch response {
//                        case .success:
//                            print("멤버추가하기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("멤버추가하기 통신 실패")
//                    }
//                }
//
//                    멤버상세보기.requestMemberDetail { response in
//                        switch response {
//                        case .success(let userinfo):
//                            print(userinfo)
//                            print("멤버상세보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("멤버상세보기 통신 실패")
//                    }
//                }
//
//                    멤버수정하기.requestMemberFix(memberInfo: MemberInfo(name: "보노보", phoneNumber: "01011111111", staffRank: "대리", staffNumber: "123")) { response in
//                        switch response {
//                        case .success:
//                            print("멤버수정하기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("멤버수정하기 통신 실패")
//                    }
//                }
//
//                    멤버회사전체보기.requestMemberAll { response in
//                        switch response {
//                        case .success:
//                            print("멤버회사전체보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("멤버회사전체보기 통신 실패")
//                    }
//                }
//
//                    고객사추가하기.requestClientAdd(clientInfo: ClientInfo(name: "보노보노주식회사", tel: "01022222222", salesRepresentativeDto: SalesRepresentativeDto(name: "보노님", phoneNumber: "01011112222", department: "포로리처리부"))) { response in
//                        switch response {
//                        case .success:
//                            print("고객사추가하기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("고객사추가하기 통신 실패")
//                    }
//                }
//
//                    고객사상세보기.requestClientDetail { response in
//                        switch response {
//                        case .success:
//                            print("고객사상세보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("고객사상세보기 통신 실패")
//                    }
//                }
//
//                    고객사수정하기.requestClientFix(clientInfo: ClientInfo(name: "보노보노주식회사", tel: "01022222222", salesRepresentativeDto: SalesRepresentativeDto(name: "보노님", phoneNumber: "01011112222", department: "뽀로리처리부"))) { response in
//                        switch response {
//                        case .success:
//                            print("고객사_수정 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("고객사_수정 통신 실패")
//                    }
//                }
//
//                    고객사전체보기.requestClientAll { response in
//                        switch response {
//                        case .success:
//                            print("고객사_전체보기 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("고객사_전체보기 통신 실패")
//                    }
//                }
                    
//                    카테고리추가하기.requestCategoryAdd(categoryInfo: CategoryInfo(name: "A/S/수정해용", color: "D813A2")) { response in
//                        switch response {
//                        case .success:
//                            print("카테고리_수정 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("카테고리_수정 통신 실패")
//                    }
//                }
//
//
//                    카테고리수정.requestCategoryFix(categoryInfo: CategoryInfo(name: "A/S/수정해용", color: "D813A2")) { response in
//                        switch response {
//                        case .success:
//                            print("카테고리_수정 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("카테고리_수정 통신 실패")
//                    }
//                }
                    
//                    카테고리전체보기.requestCategoryAll { response in
//                        switch response {
//                        case .success:
//                            print("카테고리_전체 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("카테고리_전체 통신 실패")
//                    }
//                }
//
//                    카테고리삭제하기.requestCategoryRemove(taskCategoryIdList: [0]){ response in
//                        switch response {
//                        case .success:
//                            print("카테고리_삭제 통신 성공 : StatusCode에 따라 진짜 성공과 뷰 처리 상황 파악")
//                        default : print("카테고리_삭제 통신 실패")
//                    }
//                }
                    //회사 추가
                    //회사 추가 성공했는 지 확인
                    // : 토큰 만료 시 다시 재로그인 후(추후 재발급 과정 바뀔 수도 있음) 로직 수행 테스트
                    
                    
//                }
