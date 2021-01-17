//
//  ViewController.swift
//  CSButton
//
//  Created by 이영우 on 2021/01/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        let csBtn = CSButton(frame: frame)
        self.view.addSubview(csBtn)
        
        let csBtn2 = CSButton()
        csBtn2.frame = CGRect(x: 30, y: 90, width: 150, height: 30)
        csBtn2.backgroundColor = .green
        csBtn2.addTarget(self, action: #selector(printxy(_ :)), for: .touchUpInside)
        self.view.addSubview(csBtn2)
        
        let rectBtn = CSButton(type: .rect)
        rectBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        //인자값에 따라 다른 스타일로 결정되는 버튼1
        
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        //인자값에 따라 다른 스타일로 결정되는 버튼2
        
        let circleBtn1 = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn1)
        
        circleBtn1.style = .rect
        
    }

    @objc func printxy(_ sender: Any){
        print(123)
    }
    
    
}


