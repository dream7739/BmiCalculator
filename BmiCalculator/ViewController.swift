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
    
    private var maxHeightValue = 300.0
    private var maxWeightValue = 500.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImageView.image = UIImage(named: "image")
        
        designLabel(mainTitleLabel, contentText: "BMI Calculator", textFont: UIFont.boldSystemFont(ofSize: 25), fontColor: .black)
        designLabel(subTitleLabel, contentText: "당신의 BMI 지수를\n알려드릴게요", textFont: UIFont.systemFont(ofSize: 17), fontColor: .black)
        designLabel(nicknameLabel, contentText: "닉네임이 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        designLabel(heightDescriptLabel, contentText: "키가 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        designLabel(weightDescriptLabel, contentText: "몸무게는 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        designLabel(validCheckLabel, contentText: "", textFont: UIFont.systemFont(ofSize: 14), fontColor: .purple)
        designLabel(recentBmiLabel, contentText: "최근 내 기록", textFont: UIFont.systemFont(ofSize: 12), fontColor: .darkGray)
        
        designTextField(nicknameTextField)
        designTextField(heightTextField)
        designTextField(weightTextField)
        
        resetButton.setTitle("초기화", for: .normal)
        resetButton.tintColor = .black
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        randomBmiButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBmiButton.tintColor = .red
        randomBmiButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.titleLabel?.font = .systemFont(ofSize: 17)
        resultButton.layer.cornerRadius = 10
        
        let weight =  String(format: "%.2f", UserDefaults.standard.double(forKey: "weight"))
        let height = String(format: "%.2f", UserDefaults.standard.double(forKey: "height"))
        let nickname = UserDefaults.standard.string(forKey: "nickname") ?? "정보없음"
        recentBmiLabel.text = "최근 \(nickname)님의 정보 \n키: \(height)cm  \n몸무게: \(weight)kg "
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        nicknameTextField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        let randomHeight = Int.random(in: 1...Int(maxHeightValue))
        let randomWeight = Int.random(in: 1...Int(maxWeightValue))
        
        heightTextField.text = "\(randomHeight)"
        weightTextField.text = "\(randomWeight)"
    }
    
    //결과 확인 버튼 클릭 시
    @IBAction func clickResultButton(_ sender: UIButton) {
        //신체질량지수(BMI) = 체중(kg) / [신장(m)]2
        var bmiValue: Double
        
        guard let heightText = heightTextField.text?.trimmingCharacters(in: .whitespaces),
              let weightText = weightTextField.text?.trimmingCharacters(in: .whitespaces),
              let nicknameText = nicknameTextField.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        if nicknameText == "" || weightText == "" || heightText == "" {
            validCheckLabel.text = "필수값 입력이 필요합니다."
            return
        }
        
        guard let convertedHeight = Double(heightText), let convertedWeight = Double(weightText) else{
            validCheckLabel.text = "숫자를 입력해주세요"
            return
        }
        
        let isValid = heightWeightIsValide(weight: convertedWeight, height: convertedHeight)
        
        //유효값이면 값 저장을 실행
        if isValid {
            bmiValue = calculateBmi(weight: convertedWeight, height: convertedHeight)
            presentBmiAlert(value: String(format: "%.2f", bmiValue))
            saveRecentBmiData(convertedWeight, convertedHeight, nicknameText)
        }else{
            validCheckLabel.text = "유효한 범위의 숫자를 입력해주세요"
        }
        
    }
    
    private func saveRecentBmiData(_ weight: Double, _ height: Double, _ nickname: String){
        UserDefaults.standard.setValue(weight, forKey: "weight")
        UserDefaults.standard.setValue(height, forKeyPath: "height")
        UserDefaults.standard.setValue(nickname, forKeyPath: "nickname")
    }
    
    private func calculateBmi(weight: Double, height: Double) -> Double {
        let convertedHeight = height / 100
        let bmi = weight / (convertedHeight * convertedHeight)
        return bmi
    }
    
    private func heightWeightIsValide(weight: Double, height: Double) -> Bool{
        if (weight > 0 && weight <= maxWeightValue) && (height > 0 && height <= maxHeightValue){
            return true
        }else{
            return false
        }
    }
    
    private func presentBmiAlert(value: String){
        let bmiAlert = UIAlertController(title: "BMI", message: "\(value)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        bmiAlert.addAction(confirmAction)
        present(bmiAlert, animated: true)
    }
    
    
    private func designLabel(_ sender: UILabel, contentText: String, textFont: UIFont, fontColor: UIColor){
        sender.text = contentText
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
    
}

