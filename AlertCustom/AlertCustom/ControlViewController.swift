//
//  ControlViewController.swift
//  AlertCustom
//
//  Created by 이영우 on 2021/01/17.
//

import UIKit

class ControlViewController: UIViewController {

    private let slider = UISlider()
    //이 키워드는 같은 클래스 내에서만 참조할 수 있도록 하는 접근 제한자이다. 이 키워드를 붙이는 순간 외부에서는 더 이상 slider 상수에 직접 접근할 수 없습니다.
    // 대신 우리가 연산 프로퍼티를 통해 제공하는 값만 읽어갈 수 있다.
    var sliderValue: Float{
        return self.slider.value
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height + 10) 
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
