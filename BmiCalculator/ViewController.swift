//
//  ViewController.swift
//  BmiCalculator
//
//  Created by 홍정민 on 5/21/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var heightDescriptLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightDescriptLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var validCheckLabel: UILabel!
    @IBOutlet var randomBmiButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImageView.image = UIImage(named: "image")
        
        designLabel(mainTitleLabel, contentText: "BMI Calculator", textFont: UIFont.boldSystemFont(ofSize: 25), fontColor: .black)
        designLabel(subTitleLabel, contentText: "당신의 BMI 지수를\n알려드릴게요", textFont: UIFont.systemFont(ofSize: 17), fontColor: .black)
        
        designLabel(heightDescriptLabel, contentText: "키가 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        
        designLabel(weightDescriptLabel, contentText: "몸무게는 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        
        designLabel(validCheckLabel, contentText: "", textFont: UIFont.systemFont(ofSize: 14), fontColor: .purple)
        
        randomBmiButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBmiButton.tintColor = .red
        randomBmiButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.titleLabel?.font = .systemFont(ofSize: 17)
        resultButton.layer.cornerRadius = 10
    }
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //결과 확인 버튼 클릭 시
    @IBAction func clickResultButton(_ sender: UIButton) {
        //신체질량지수(BMI) = 체중(kg) / [신장(m)]2
        var inputHeight: Float
        var inputWeight: Float
        var bmiValue: Float
        
        if let height = heightTextField.text?.trimmingCharacters(in: .whitespaces) {
            if let convertedHeight = Float(height){
                
                inputHeight = convertedHeight / 100
                
                if let weight = weightTextField.text?.trimmingCharacters(in: .whitespaces) {
                    if let convertedWeight = Float(weight){
                        inputWeight = convertedWeight
                        
                        let isValide: Bool = heightWeightIsValide(weight: convertedWeight, height: convertedHeight)
                        
                        if isValide {
                            bmiValue = inputWeight / (inputHeight * inputHeight)
                            let bmiText = String(format: "%.2f", bmiValue)
                            presentBmiAlert(value: bmiText)
                        }else{
                            validCheckLabel.text = "유효하지 않은 범위의 숫자입니다"
                        }
                    }
                }
            }
            
            
        }
    }
    
    fileprivate func heightWeightIsValide(weight: Float, height: Float) -> Bool{
        if weight > 1000 && height > 300 {
            return false
        }
        return true
    }
    
    fileprivate func presentBmiAlert(value: String){
        let bmiAlert = UIAlertController(title: "BMI", message: "\(value)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        bmiAlert.addAction(confirmAction)
        present(bmiAlert, animated: true)
    }
    
    
    fileprivate func designLabel(_ sender: UILabel, contentText: String, textFont: UIFont, fontColor: UIColor){
        sender.text = contentText
        sender.font = textFont
        sender.textColor = fontColor
    }
    
}

