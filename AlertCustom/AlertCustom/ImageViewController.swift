//
//  ImageViewController.swift
//  AlertCustom
//
//  Created by 이영우 on 2021/01/17.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon = UIImage(named: "rating5")
        let iconv = UIImageView(image: icon)
        //이미지 객체와 이미지뷰 객체를 생성
        
        iconv.frame = CGRect(x: 0, y: 0, width: (icon?.size.width)!, height: (icon?.size.height)!)
        //이미지 뷰의 영역과 위치를 지정한다. 영역정의가 반드시 필요하다
        
        self.view.addSubview(iconv)
        //이미지 뷰를 뷰에 추가해준다.
        
        self.preferredContentSize = CGSize(width: (icon?.size.width)!, height: (icon?.size.height)! + 10)

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
