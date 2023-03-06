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
        return self.count == 6
    }
    
    var isValidPhoneNumber: Bool {
        let phoneNumberRegEx = "^01[0-1, 7][0-9]{7,8}$"
        
        let phoneNumbePred = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumbePred.evaluate(with: self)
    }
}
