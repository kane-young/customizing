//
//  ViewController.swift
//  Button_Custom
//
//  Created by 이영우 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {
    
    
    var paramEmail: UITextField!
    var paramUpdate: UISwitch!
    var paramInterval: UIStepper! // 스테퍼
    var textUpdate: UILabel!
    var textInterval: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "설정"
        
        let lblEmail = UILabel()
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblEmail)
       
        let customFont = UIFont(name: "Montserrat-Bold", size: 30)
        let lblUpdate = UILabel()
        lblUpdate.frame = CGRect(x: lblEmail.frame.origin.x , y: 150, width: 100, height: 30)
        lblUpdate.font = customFont
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblUpdate)
        //label 자동갱신
        
        let lblInterval = UILabel()
        lblInterval.frame = CGRect(x: lblEmail.frame.origin.x, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblInterval)
        //label 갱신주기
        
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextField.BorderStyle.roundedRect
        self.paramEmail.autocapitalizationType = .none
        
        self.view.addSubview(self.paramEmail)
        //textField
        
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(self.paramUpdate)
        //Switch - setOn(: 초기값을 나타냄)
        
        self.paramInterval = UIStepper()
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0
        self.paramInterval.maximumValue = 100
        self.paramInterval.stepValue = 1 // 스테퍼의 값 변경 단위
        self.paramInterval.value = 0 //초기값 지정
        //Stepper -, +를 눌러서 숫자를 올리는 것
        self.view.addSubview(self.paramInterval)
        
        self.textUpdate = UILabel()
        self.textUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.textUpdate.font = UIFont.systemFont(ofSize: 12)
        self.textUpdate.textColor = UIColor.red
        self.textUpdate.text = "갱신함"
        self.textUpdate.textColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0)
        self.view.addSubview(self.textUpdate)
        //label  갱신함
        
        self.textInterval = UILabel()
        self.textInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.textInterval.font = UIFont.systemFont(ofSize: 12)
        self.textInterval.textColor = UIColor.red
        self.textInterval.text = "0분마다"
        self.view.addSubview(textInterval)
        
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_: )))
            
        self.navigationItem.rightBarButtonItem = submitBtn
    }
    
    @objc func presentUpdateValue(_ sender: UISwitch){
        self.textUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    @objc func presentIntervalValue(_ sender: UIStepper){
        self.textInterval.text = ("\(Int(sender.value))분마다")
    }

    @objc func submit(_ sender: Any){
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }

}

