//
//  CSTabBarController.swift
//  CSTabBar
//
//  Created by 이영우 on 2021/01/18.
//

import UIKit

class CSTabBarController: UITabBarController {

    let csView = UIView()
    let tabItem01 = UIButton(type: .system)
    let tabItem02 = UIButton(type: .system)
    let tabItem03 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        //기존 탭 바를 숨김 처리
        
        
        let width = self.view.frame.width
        let height: CGFloat = 50
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = UIColor.brown
        self.view.addSubview(self.csView)
        //탭바를 숨김처리하고 그 위에 csView를 하나 만듬
        
        let tabBtnWidth = self.csView.frame.size.width / 3
        let tabBtnHeight = self.csView.frame.size.height
        self.tabItem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem03.frame = CGRect(x: tabBtnWidth * 2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.addTabBarButton(btn: self.tabItem01, title: "첫 번째 버튼", tag: 0)
        self.addTabBarButton(btn: self.tabItem02, title: "두 번째 버튼", tag: 1)
        self.addTabBarButton(btn: self.tabItem03, title: "세 번째 버튼", tag: 2)
        
        self.onTabBarItemClick(self.tabItem01)
    }
    
    func addTabBarButton(btn: UIButton, title: String, tag: Int){
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.yellow, for: .selected)
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
        self.csView.addSubview(btn)
    }

    @objc func onTabBarItemClick(_ sender: UIButton){
        
        //모든 버튼을 선택되지 않은 상태로 초기화 처리한다.
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        
        sender.isSelected = true
        //인자값으로 입력된 버튼만 선택된 상태로 변경한다.
        self.selectedIndex = sender.tag
    }
    
}
