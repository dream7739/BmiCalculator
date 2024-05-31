//
//  BMI.swift
//  BmiCalculator
//
//  Created by 홍정민 on 5/31/24.
//

import Foundation

struct BMI{
    typealias BMIValue = Double
    var height: BMIValue
    var weight: BMIValue
    var nickName: String = ""
    
    let maxHeight: Double = 300
    
    let maxWeight: Double = 500
    
    var randomHeight : Int {
        return Int.random(in: 0...Int(maxHeight))
    }
    
    var randomWeight : Int {
        return Int.random(in: 0...Int(maxWeight))
    }
    
    var bmi: Double {
        get{
            weight / ((height * 0.01) * (height * 0.01))
        }
    }
    
    var nickNameDescription: String {
        get {
            if nickName.isEmpty {
                return "정보없음"
            }else{
                return nickName

            }
        }
    }
    
    var heightDescription: String {
        String(format: "%.2f", height) + "cm"
    }
    
    var weightDescription: String {
        String(format: "%.2f", weight) + "kg"
    }
    
    var bmiDescription: String {
        String(format: "%.2f", bmi)
    }
    
    var resultDescription: String {
        return #"최근 \#(nickNameDescription)님의 정보\#n키: \#(heightDescription)\#n몸무게: \#(weightDescription)\#nbmi: \#(bmiDescription)"#
    }
}
