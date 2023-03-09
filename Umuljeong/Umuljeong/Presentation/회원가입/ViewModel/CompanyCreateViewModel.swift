//
//  CompanyCreateViewModel.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/02/10.
//

import Foundation
import Combine


class CompanyCreateViewModel: ObservableObject {
    @Published var moveMainTab: Bool = false
    @Published var company:String = ""
    @Published var manager:String = ""
    @Published var isValid:Bool = false
    
    let createRepository = CompanyCreateRepositoryImpl()
    let myUniqueInfoRepository = MemberUniqueInfoRepository()
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
      isSignupFormValidPublisher
        .receive(on: RunLoop.main)
        .assign(to: \.isValid, on: self)
        .store(in: &publishers)
    }
    
    func requestCreateCompany() { //회사 생성
        createRepository.requestCreateCompany(name: company) { result in
            switch result {
            case .success(_):
                self.requestUniqueUserInfo {
                    self.moveMainTab = true
                }
            case .failure(_):
                self.moveMainTab = false
                //에러창 출력 
            }
        }
    }
    
    func requestUniqueUserInfo(completion: @escaping () -> ()) {
        myUniqueInfoRepository.requestMyUniqueInfo { result in
            switch result {
            case .success(_): completion()
            case .failure(_): completion()
            }
        }
    }
    
    
    var companyValidPublisher: AnyPublisher<Bool, Never> {
      $company
        .map { company in
            return company.count >= 1
        }
        .eraseToAnyPublisher()
    }

    var managerValidPublisher: AnyPublisher<Bool, Never> {
      $manager
        .map { manager in
            return manager.count >= 1
        }
        .eraseToAnyPublisher()
    }

    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
      Publishers.CombineLatest(
        companyValidPublisher,
        managerValidPublisher)
        .map {companyValid, managerValid in
            return companyValid && managerValid
        }
        .eraseToAnyPublisher()
    }
}
