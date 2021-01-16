//
//  ViewController.swift
//  TabBar_Practice
//
//  Created by 이영우 on 2021/01/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "첫 번째 탭"
        title.textColor = .red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit()//콘텐츠의 내용에 맞게 레이블 크기 변경
        
        //sizeToFit 메소드와 center 속성 결정 구문을 함께 사용할 경우, 객체의 center 속성 설정은 항상 sizeToFit 메소드를 호출한 후에 처리하는 것이 좋습니다. 만약 center 속성을 먼저 설정하고 sizeToFit 메소드를 나중에 지정한다면
        
        //center 속성을 설정하는 시점에 레이클의 크기는 100포인트였기 때문에, 이후에 sizeToFit 메소드 때문에 객체의 크기가 커지더라도, 이미 지정해 놓은 center 속성은 이를 반영하지 못한다.
        
        //그래서 객체의 크기를 정해준 다음에 center 속성의 값을 설정하는 것이 안전하다
        
        
        title.center.x = self.view.frame.width / 2
        //x 축의 중앙에 오도록
        
        self.view.addSubview(title)
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        
        UIView.animate(withDuration: TimeInterval(0.15), animations: {
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0 )
        })
    }

}

