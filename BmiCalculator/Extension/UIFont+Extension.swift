//
//  UIFont+Extension.swift
//  BmiCalculator
//
//  Created by 홍정민 on 5/31/24.
//

import UIKit

extension UIFont {
    static var primary: UIFont{
        return .boldSystemFont(ofSize: 25)
    }
    
    static var secondary: UIFont {
        return .systemFont(ofSize: 17)
    }
    
    static var tertiary: UIFont {
        return .systemFont(ofSize: 14)
    }
}
