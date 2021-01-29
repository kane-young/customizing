//
//  ViewController.swift
//  NavigationBar_Custom
//
//  Created by 이영우 on 2021/01/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.initTitle()
//        self.initTitleNew()
//        self.initTitleImage()
        self.initTitleInput()
    }


    func initTitle(){
        //1번
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.font = UIFont.systemFont(ofSize: 15)//폰트 크기
        nTitle.textColor = .white
        nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)"
        
        self.navigationItem.titleView = nTitle
        
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
        
        
    }
    
    func initTitleNew(){
        //2번 UIView에 title과 subTitle을 넣고 올려주기
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.textColor = UIColor.white
        topTitle.text = "58개 숙소"
        
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = .white
        subTitle.text = "1박(1월 10일 ~ 1월 11일"
        
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationItem.titleView = containerView
    }
    
    func initTitleImage(){
        let image = UIImage(named: "swift_logo")
        let imageV = UIImageView(image: image)
        
        self.navigationItem.titleView = imageV
        
    }
    
    func initTitleInput(){
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tf.backgroundColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.autocapitalizationType = .none//자동 대문자 변환 속성 x
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .URL
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3
        tf.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.60, alpha: 1.0).cgColor
        
        self.navigationItem.titleView = tf
        
        /*let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 150, height: 37)
        v.backgroundColor = UIColor.brown
        
        let leftItem = UIBarButtonItem(customView: v)
        self.navigationItem.leftBarButtonItem = leftItem*/
        
        let back = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(image: back, style: .plain, target: self, action: nil)
        
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        /*let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 100, height: 37)
        rv.backgroundColor = .red
        
        let rightItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rightItem*/
        
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        
        let rItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rItem
        
        
        //카운트 값을 표시할 레이블 구성
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
        cnt.textAlignment = .center
        cnt.text = "12"
        
        cnt.layer.cornerRadius = 3
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        rv.addSubview(cnt)
        
        let more = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        
        rv.addSubview(more)
    }
    
    
}
