//
//  FrontViewController.swift
//  SideBarDIY
//
//  Created by 이영우 on 2021/01/20.
//

import UIKit

class FrontViewController: UIViewController {
    var delegate: RevealViewController?
    //델리게이트 변수는 특정 기능을 위임할 대상을 지정하기 위한 변수이다.
    
    @objc func moveSide(_ sender: Any){
        
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem{
            if self.delegate?.isSideBarShowing == false{
                self.delegate?.openSideBar(nil)
            } else{
                self.delegate?.closeSideBar(nil)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide))
        
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)//뷰에 제스처 객체를 등록
        
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)//뷰에 제스처 객체를 등록
        
    }
}
