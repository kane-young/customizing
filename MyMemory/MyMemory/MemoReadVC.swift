//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 이영우 on 2021/01/08.
//

import UIKit

class MemoReadVC: UIViewController {

    var param: MemoData?
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH: mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)

        
        self.navigationItem.title = dateString
        //내비게이션 타이틀에 날짜를 표시
        
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
