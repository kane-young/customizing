//
//  RevealViewController.swift
//  SideBarDIY
//
//  Created by 이영우 on 2021/01/20.
//

import UIKit

class RevealViewController: UIViewController {
    
    var contentVC: UIViewController?
    var sideVC: UIViewController?
    
    var isSideBarShowing = false
    
    let SLIDE_TIME = 0.3 //사이드 바가 열리고 닫히는데 걸리는 시간
    let SIDEBAR_WIDTH: CGFloat = 260
    //사이드 바가 열릴 너비
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView(){
        //초기화면을 설정한다.
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController{
            
            self.contentVC = vc
            
            self.addChild(vc)
            self.view.addSubview(vc.view)
            
            vc.didMove(toParent: self)
            //front 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
            
            //프론트 컨트롤러의 델리게이트 변수에 참조 정보를 넣어준다.
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    
    func getSideView(){
        //사이드 바의 뷰를 읽어온다.
        guard self.sideVC == nil else{
            return
        }
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") else{
            return
        }
        
        //다른 메소드에서도 참조할 수 있도록 sideVC 속성에 저장한다.
        self.sideVC = vc
        //읽어온 사이드 바 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결한다.
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        //프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
        vc.didMove(toParent: self)
        
        //프론트 컨트롤러의 뷰를 제일 위로 올린다.
        self.view.bringSubviewToFront((self.contentVC?.view)!)
    }
    
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        //콘텐츠 뷰에 그림자 효과를 준다.
        //sideBar 가 열릴때 깊이감을 주기 위하여
        if (shadow == true){
            self.contentVC?.view.layer.masksToBounds = false
            self.contentVC?.view.layer.cornerRadius = 10 //그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8 // 그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else{
            self.contentVC?.view.layer.cornerRadius = 0.0;
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0);
        }
        
    }
    
    func openSideBar(_ complete: ( () -> Void)? ){
        //사이드 바를 연다.
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2) //그림자 효과를 준다.
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations: {
                self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: {
                if $0 == true{
                    self.isSideBarShowing = true
                    complete?()
                }
            })
    }
    
    func closeSideBar(_ complete: ( () -> Void)? ){
        //사이드 바를 닫는다.
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
                self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: {
                if $0 == true{
                    self.sideVC?.view.removeFromSuperview()
                    //사이드 바를 제거한다.
                    self.sideVC = nil
                    self.isSideBarShowing = false
                    self.setShadowEffect(shadow: false, offset: 0)
                    complete?()
                }
            })
    }
}
