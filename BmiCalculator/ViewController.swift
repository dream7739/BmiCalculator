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
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var heightDescriptLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightDescriptLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var validCheckLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var randomBmiButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var recentBmiLabel: UILabel!
    
    private var bmi = BMI(height: 0, weight: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureData()
    }
    
}

extension ViewController {
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        nicknameTextField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        heightTextField.text = "\(bmi.randomHeight)"
        weightTextField.text = "\(bmi.randomWeight)"
    }
    
    //결과 확인 버튼 클릭 시
    @IBAction func resulltButtonClicked(_ sender: UIButton) {
        //신체질량지수(BMI) = 체중(kg) / [신장(m)]2
        
        guard let heightText = heightTextField.text?.trimmingCharacters(in: .whitespaces),
              let weightText = weightTextField.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        if weightText.isEmpty || heightText.isEmpty {
            validCheckLabel.text = "필수값 입력이 필요합니다."
            return
        }
        
        guard let convertedHeight = Double(heightText),
              let convertedWeight = Double(weightText) else{
            validCheckLabel.text = "숫자를 입력해주세요"
            return
        }
        
        if  convertedWeight > 0 && convertedWeight <= bmi.maxWeight &&
                convertedHeight > 0 && convertedHeight <= bmi.maxHeight {
            
            bmi.nickName = nicknameTextField.text!.trimmingCharacters(in: .whitespaces)
            bmi.height = convertedHeight
            bmi.weight = convertedWeight
            
            presentBMIAlert(value: bmi.bmiDescription)
            
            saveUserDefaultsData()
            
        }else{
            validCheckLabel.text = "유효한 범위의 숫자를 입력해주세요"
        }
        
    }
    
    private func configureLayout(){
        mainImageView.image = UIImage.mainImage
        
        designLabel(mainTitleLabel, textFont: .primary, fontColor: .black)
        designLabel(subTitleLabel, textFont: .secondary, fontColor: .black)
        designLabel(nicknameLabel, textFont: .tertiary, fontColor: .black)
        designLabel(heightDescriptLabel, textFont: .tertiary, fontColor: .black)
        designLabel(weightDescriptLabel, textFont: .tertiary, fontColor: .black)
        designLabel(validCheckLabel, textFont: .tertiary, fontColor: .purple)
        designLabel(recentBmiLabel,  textFont: .tertiary, fontColor: .darkGray)
        
        mainTitleLabel.text = "BMI Calculator"
        subTitleLabel.text = "당신의 BMI 지수를\n알려드릴게요"
        nicknameLabel.text = "닉네임이 어떻게 되시나요?"
        heightDescriptLabel.text = "키가 어떻게 되시나요?"
        weightDescriptLabel.text = "몸무게는 어떻게 되시나요?"
        validCheckLabel.text = ""
        recentBmiLabel.text = "최근 내 기록"
        
        designTextField(nicknameTextField)
        designTextField(heightTextField)
        designTextField(weightTextField)
        
        designResetButton()
        designRandomButton()
        designResultButotn()
        
    }
    
    private func configureData(){
        fetchUserDefaultsData()
        recentBmiLabel.text = bmi.resultDescription
    }
    
    private func presentBMIAlert(value: String){
        let bmiAlert = UIAlertController(title: "BMI", message: "\(value)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        bmiAlert.addAction(confirmAction)
        present(bmiAlert, animated: true)
    }
    
    private func saveUserDefaultsData(){
        BMIManager.nickname = bmi.nickName
        BMIManager.height = bmi.height
        BMIManager.weight = bmi.weight
    }
    
    private func fetchUserDefaultsData(){
        bmi.nickName = BMIManager.nickname
        bmi.height = BMIManager.height
        bmi.weight = BMIManager.weight
    }
    
    private func designLabel(_ sender: UILabel, textFont: UIFont, fontColor: UIColor){
        sender.font = textFont
        sender.textColor = fontColor
        sender.numberOfLines = 0
    }
    
    private func designTextField(_ sender: UITextField){
        sender.layer.cornerRadius = 15
        sender.layer.borderColor = UIColor.black.cgColor
        sender.layer.borderWidth = 1.3
        sender.tintColor = .purple
        sender.clearButtonMode = .whileEditing
    }
    
    private func designResetButton(){
        resetButton.setTitle("초기화", for: .normal)
        resetButton.tintColor = .black
        resetButton.titleLabel?.font = .secondary
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 1.3
    }
    
    private func designRandomButton(){
        randomBmiButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBmiButton.tintColor = .red
        randomBmiButton.titleLabel?.font = .tertiary
    }
    
    private func designResultButotn(){
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.titleLabel?.font = .secondary
        resultButton.layer.cornerRadius = 10
    }
}

