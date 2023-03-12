//
//  String + Extension.swift
//  Umuljeong
//
//  Created by 박혜운 on 2023/03/06.
//

import Foundation





extension String {
    
    var passwordEight: Bool {
        let phoneNumberRegEx = "^.{8,20}$"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var passwordLargeSmallEng: Bool {
        let phoneNumberRegEx = "^(?=.*[a-z])(?=.*[A-Z]).+"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var passwordContainInt: Bool {
        let phoneNumberRegEx = "^(?=.*[0-9]).+"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    var passwordContainSpecial: Bool {
        let phoneNumberRegEx = "^(?=.*[-+_!@#$%^&*., ?]).+"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
    
    
    var isValidUsername: Bool {
        return self.count > 1
    }
    
    var isValidCode: Bool {
        return self.count == 4
    }
    
    var isValidPhoneNumber: Bool {
        let phoneNumberRegEx = "^01[0-1, 7][0-9]{8}$"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
}


extension String {
    func checkColorCategory() -> CategoryColor {
        switch self {
        case "D813A2": return .first
        case "E71F2A": return .second
        case "356DF8": return .third
        case "108852": return .fourth
        case "4B5390": return .fifth
        case "FFAD0F": return .sixth
        case "8F00FF": return .seventh
        default: return .first
        }
    }
}
