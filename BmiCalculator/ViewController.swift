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
    
    @IBOutlet var randomBmiButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImageView.image = UIImage(named: "image")
        
        designLabel(mainTitleLabel, contentText: "BMI Calculator", textFont: UIFont.boldSystemFont(ofSize: 25), fontColor: .black)
        designLabel(subTitleLabel, contentText: "당신의 BMI 지수를\n알려드릴게요", textFont: UIFont.systemFont(ofSize: 17), fontColor: .black)
        
        designLabel(heightDescriptLabel, contentText: "키가 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        
        designLabel(weightDescriptLabel, contentText: "몸무게는 어떻게 되시나요?", textFont: UIFont.systemFont(ofSize: 14), fontColor: .black)
        
        randomBmiButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBmiButton.tintColor = .red
        randomBmiButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.titleLabel?.font = .systemFont(ofSize: 17)
        resultButton.layer.cornerRadius = 10
    }

    fileprivate func designLabel(_ sender: UILabel, contentText: String, textFont: UIFont, fontColor: UIColor){
        sender.text = contentText
        sender.font = textFont
        sender.tintColor = fontColor
    }

}

