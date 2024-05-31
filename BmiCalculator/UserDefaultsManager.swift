//
//  UserDefaultsManager.swift
//  BmiCalculator
//
//  Created by 홍정민 on 5/31/24.
//

import UIKit

@propertyWrapper
struct UserDefaultsManager<T>{
    let key: String
    let defaultValue: T
    let storage: UserDefaults
    
    var wrappedValue: T {
        get {
            self.storage.object(forKey: key) as? T ?? defaultValue
        }
        set{
            self.storage.set(newValue, forKey: key)
        }
    }
    
}

class BMIManager {
    @UserDefaultsManager(key: "nickname", defaultValue: "", storage: .standard)
    static var nickname: String
    
    @UserDefaultsManager(key: "weight", defaultValue: 0, storage: .standard)
    static var weight: Double
    
    @UserDefaultsManager(key: "height", defaultValue: 0, storage: .standard)
    static var height: Double
    
    
// bmi는 computed property > 가져온 값으로 연산하도록 함
//    @UserDefaultsManager(key: "bmi", defaultValue: 0, storage: .standard)
//    static var bmi: Double
    
}
