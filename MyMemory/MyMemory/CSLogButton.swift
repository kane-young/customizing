//
//  CSLogButton.swift
//  MyMemory
//
//  Created by 이영우 on 2021/01/19.
//

import UIKit

//CSLogButton 파일 상단에 로깅 타입을 정의할 열거형 객체를 추가한다.
public enum CSLogType: Int{
    case basic// 기본 로그 타입
    case title// 버튼의 타이틀을 출력
    case tag// 버튼의 태그값을 출력
}

public class CSLogButton: UIButton{
    //로그 출력 타입
    public var logType: CSLogType = .basic
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = UIColor.white
        
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    
    @objc func logging(_ sender: UIButton){
        switch self.logType{
        case .basic:
            NSLog("버튼이 클릭되었습니다.")
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
        case .tag:
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }
}
