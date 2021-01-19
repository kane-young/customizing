//
//  CSStepper.swift
//  CSStepper
//
//  Created by 이영우 on 2021/01/18.
//

import Foundation
import UIKit

@IBDesignable

public class CSStepper: UIControl{
    
    public var leftBtn = UIButton(type: .system)//좌측 버튼
    public var rightBtn = UIButton(type: .system)// 우측 버튼
    public var centerLabel = UILabel() // 중앙 레이블
    public var stepValue: Int = 1
    public var maximumValue: Int = 100
    public var minimumValue: Int = -100

    //스테퍼의 현재값을 저장할 변수
    @IBInspectable
    public var value: Int = 0{
        didSet{//value 변수의 값이 바뀌면 자동으로 호출된다.
            self.centerLabel.text = String(value)
            //프로퍼티의 값이 바뀌면 자동으로 호출된다.

            self.sendActions(for: .valueChanged)
            //이 클래스를 사용하는 객체들에게 valueChanged 이벤트 신호를 보내준다.
        }
    }
    
    //좌측 버튼의 타이틀 속성
    @IBInspectable
    public var leftTitle: String = "↓"{
        didSet{
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    //우측 버튼의 타이틀
    @IBInspectable
    public var rightTitle: String = "↑"{
        didSet{
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    //센터 영역의 색상
    @IBInspectable
    public var bgColor: UIColor = UIColor.cyan{
        didSet{
            self.centerLabel.backgroundColor = backgroundColor
        }
    }
    
    //@IBInspectable은 우리가 정의한 속성을 인터페이스 빌더에서도 설정할 수 있도록 처리해 주는 어트리뷰트입니다. 이 어트리뷰트가 붙은 프로퍼티는 어트리뷰트 인스펙터 탭의 속성 항목에 추가되어 편집 가능한 상태로 표시됩니다. 마치 오리지널 스테퍼 객체의 속성 항목들처럼 말입니다.
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.setup()
    }
    //required 키워드를 init 앞에 붙이면 이는 필수 구현 메소드가 되며, 모든 자손들이 해당 초기화 메소드를 구현해야 한다. required 메소드는 반드시 오버라이딩되어야 하는 것이므로 별도로 override 를 붙이지 않는다. 보통 프로토콜에서 이니셜라이저를 지정하는 경우에 자동으로 required가 된다.
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup(){
        //여기에 스테퍼의 기본 속성을 설정한다. frame을 제외하고 해준다. 그 이유는 밑에 나온다.
        
        let borderWidth: CGFloat = 0.5
        let borderColor = UIColor.blue.cgColor //테두리 색상값
        //좌측 다운 버튼 속성 설정
        self.leftBtn.tag = -1
//        self.leftBtn.setTitle("↓", for: .normal)
        self.leftBtn.setTitle(self.leftTitle, for: .normal)
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.leftBtn.layer.borderWidth = borderWidth
        self.leftBtn.layer.borderColor = borderColor //버튼 테두리 색상 - 파란색
        
        self.rightBtn.tag = 1
//        self.rightBtn.setTitle("↑", for: .normal)
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderWidth
        self.rightBtn.layer.borderColor = borderColor
        
        self.centerLabel.text = String(value)
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
//        self.centerLabel.backgroundColor = UIColor.cyan
        self.centerLabel.backgroundColor = self.bgColor
        self.centerLabel.layer.borderWidth = borderWidth
        self.centerLabel.layer.borderColor = borderColor
        //레이블의 테두리 색상 - 파란색
        
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
        
        self.leftBtn.addTarget(self, action: #selector(valueChange(_ : )), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_ : )), for: .touchUpInside)
        
    }
    //layoutSubviews 메소드는 뷰의 크기가 변할 때 호출되는 메소드입니다. 우리는 스토리보드에서 뷰의 리사이징 핸들을 드래그하여 크기를 임의로 바꿀 수 있을 뿐만 아니라, 프로그래밍 코드에서 뷰의 frame.size 속성값을 변경하여 원하는 크기로 바꿀 수도 있습니다. 우리가 이렇게 뷰의 크기를 재설정하면 그때마다 자동으로 layoutSubviews 메소드가 호출됩니다. 뷰의 내부에 다른 객체들이 있다면, 이 메소드 내부에 객체의 크기를 조절하는 구문을 작성함으로써 뷰의 크기 변화에 적절히 대응할 수 있습니다. 스테퍼 컨트롤의 frame 속성을 setup 메소드에서 설ㄹ정해 주지 않은 것은 이 때문입니다. 뷰의 크기가 바뀔때마다 계속 재설정해 주어야 하니까요
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let btnWidth = self.frame.height
        let lblWidth = self.frame.width - (btnWidth * 2)
        //버튼의 너비 = 뷰 높이
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth + lblWidth, y: 0, width: btnWidth, height: btnWidth)
    }
    
    @objc public func valueChange(_ sender: UIButton){
        
        let sum = self.value + (sender.tag * self.stepValue)
        //스테퍼의 값을 변경하기 전에, 미리 최소값과 최대값 범위를 벗어나지 없는지 체크한다.
    
        if sum > self.maximumValue{
            return
        }//더한 결과가 최댓값보다 크면 값을 변경하지 않고 종료
        
        if sum < self.minimumValue{
            return
        }//더한 결과가 최소값보다 작으면 값을 변경하지 않고 종료
        
        self.value += (sender.tag * self.stepValue)
        //sender의 tag가 +1 or -1 이기때문에 값에 +1 or -1이다
        
    }
    
    
}
