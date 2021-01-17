//
//  CSButton.swift
//  CSButton
//
//  Created by 이영우 on 2021/01/17.
//

import Foundation
import UIKit

public enum CSButtonType{
    case rect
    case circle
}

class CSButton: UIButton{
    
    var style: CSButtonType = .rect{
        didSet{
            //프로퍼티 옵저버는 프로퍼티 값이 변할 때마다 자동으로 호출되는 코드 블록이다.
            switch style {
            case .rect:
                self.backgroundColor = UIColor.black
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 0
                self.setTitleColor(.white, for: .normal)
                self.setTitle("Rect Button", for: .normal)
            case .circle:
                self.backgroundColor = UIColor.red
                self.layer.borderColor = UIColor.blue.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 50
                self.setTitle("Circle Button", for: .normal)
            }
        }
         
        willSet{
            
            
        }
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.backgroundColor = UIColor.green
        self.layer.borderWidth = 2//테두리는 조금 두껍게
        self.layer.borderColor = UIColor.black.cgColor //테두리는 검은색으로
        self.setTitle("버튼", for: .normal) //기본 문구 설정
    }
    //CSButton 클래스에 초기화 메소드 init(coder: )를 정의합니다.
    
//    init(coder: ) 구문은 스토리보드 방식으로 객체를 생성할 때 호출되는 초기화 메소드입니다. 다시 말해, 스토리보드에서 CSButton 클래스 타입의 버튼 객체를 사용하면 이 초기화 메소드가 사용된다는 겁니다.
    
    //프로그래밍 코드에서 객체를 사용할 때 초기화 메소드를 호출하는 것과 마찬가지로 스토리보드에서도 객체를 초기화하기 위해 초기화 메소드를 호출합니다. 하지만 객체들마다 초기화 메소드 형식이 제각각이라면 스토리보드가 알아서 초기화 메소드를 호출하기 어렵다 그래서 스토리보드에서 사용하는 초기화 메소드는 init(coder: )로 규격화되어 있다. 스토리보드에서는 오직 이 형식의 초기화 메소드만 호출하는 겁니다.
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드로 생성된 버튼", for: .normal)
    }//이번에는 CGRect 타입의 인자값을 입력받는 초기화 메소드를 정의하였다. 프로그래밍 방식으로 버튼 객체를 생성할 때 사용할 메소드이다. 물론 프로그래밍 방식으로 버튼 객체를 생성하더라도 앞에서 정의한 init(coder:)메소드를 사용할 수 있긴 하다. 하지만 이 메소드를 사용하기 위해 넣어주는 인자값은 대부분 스토리보드에서 자동으로 생성되는 NSCoder 타입의 값이기 때문에, 이 값을 우리가 직접 만들어 사용하기는 조금 어렵습니다. 일단은 NSCoder 타입에 어떤 값을 넣어주어야 하는지도 모르니까요. 따라서 프로그래밍 방식에서 호출하기 쉽도록 초기화 메소드를 따로 정의해 주는 것이 좋습니다.
    
    init(){
        super.init(frame: CGRect.zero)
        
    }//이 메소드 덕분에, 우리는 이제 인자값 없이도 CSButton 객체를 정의할 수 있습니다. 이 메소드는 인자값을 입력받지 않지만 내부적으로는 앞의 두 초기화 메소드와 동일하게 부모 클래스의 초기화 메소드를 호출해 줍니다. 이를 위해 임의의 인자값을 생성하여 부모 클래스의 초기화 메소드를 호출하는데, 이때 인자값으로 사용된 CGRect.zero는 모든 프로퍼티의 초기값이 0인 CGRect 객체를 의미합니다. 주로 정확한 값이 없는 상태에서 CGRect 객체를 초기화할때 많이 사용하며, 다음과 같은 의미로 받아들이면 됩니다.
    
    //CGRect(x: 0, y: 0, width: 0, height: 0)
//    이 값을 사용하여 객체를 생성할 경우 frame 속성이 모두 (0,0,0,0)되기 때문에 나중에 적절한 값으로 frame 속성을 설정해 주어야 합니다. 그렇지 않으면 화면에서 버튼 객체가 표시되지 않습니다.
    
//    이렇게 작성된 초기화 메소드를 사용하여 버튼을 생성하는 방법을 봅시다.
    
    convenience init(type: CSButtonType){
        self.init()
        //이 초기화 메소드는 Step1에서 정의한 CSButtonType 타입을 인자값으로 입력받습니다. 이 값을 구분하여 서로 다른 속성을 적용해 주면 간단히 스타일을 선택할 수 있는 버튼이 만들어집니다. 아울러 이 메소드는 편의 초기화 메소드로 정의되었으므로, 부모의 초기화 메소드를 호출하는 것이 아니라 자신의 지정 초기화 메소드 중 하나를 호출하게 합니다.
        
        switch type{
        case .rect:
            self.backgroundColor = UIColor.black
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitle("Rect Button", for: .normal)
        case .circle:
            self.backgroundColor = UIColor.red
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 50
            self.setTitle("Circle Button", for: .normal)
        }
        
        self.addTarget(self, action: #selector(counting(_:)), for: .touchUpInside)
    }
    
    @objc func counting(_ sender: UIButton){
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag) 번째 클릭", for: .normal)
    }
    //버튼이 클릭된 횟수를 카운트하려면 현재의 카운트 횟수를 저장해 놓을 클래스 레벨의 변수가 필요합니다. 이 변수를 CSButton 클래스에 직접 추가해서 사용하는 방법도 있지만, 여기서는 변수를 직접 정의하지 않고 tag속성을 활용하여 카운트 횟수를 저장하고 있다. tag속성도 클래스 레벨에서 정의된 프로퍼티이며, 값의 타입 역시 Int로 정의되어 있기 때문이다.
    

}
