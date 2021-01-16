//
//  ViewController.swift
//  AlertCustom
//
//  Created by 이영우 on 2021/01/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaultAlertBtn = UIButton(type: .system)
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width / 2
        defaultAlertBtn.setTitle("기본 알림창", for: .normal)
        defaultAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(defaultAlertBtn)
    }
    
    @objc func defaultAlert(_ sender: Any){
        let alert = UIAlertController(title: nil, message: "기본 메시지", preferredStyle: .actionSheet)
        
        let v = UIViewController()
        // 알림창에 들어갈 뷰 컨트롤러
        v.view.backgroundColor = .red
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.setValue(v, forKey: "contentViewController")
        
        self.present(alert, animated: false)
        
    }


}

