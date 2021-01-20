//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 이영우 on 2021/01/08.
//

import UIKit

class MemoFormVC: UIViewController, UITextViewDelegate {

    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    var subject: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.contents.delegate = self
        
        if let bgImage = UIImage(named: "memo-background.png"){
            self.view.backgroundColor = UIColor(patternImage: bgImage)
        }
        
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
        
        
        //줄간격
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.paragraphStyle: style])
        self.contents.text = ""
    }
    
    @IBAction func pick(_ sender: Any) {
        let alert = UIAlertController(title: "선택", message: "이미지를 가져올 곳을 선택해주세요", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
                let picker = UIImagePickerController()
                
                picker.delegate = self
                picker.sourceType = .camera
                picker.allowsEditing = true
                
                self.present(picker, animated: false, completion: nil)
            
            
        }))
        alert.addAction(UIAlertAction(title: "저장앨범", style: .default, handler: { _ in
                let picker = UIImagePickerController()
                
                picker.delegate = self
                picker.allowsEditing = true
                
                self.present(picker, animated: false)
            
        }))
        
        alert.addAction(UIAlertAction(title: "사진 라이브러리", style: .default, handler: { _ in
                let picker = UIImagePickerController()
                
                picker.delegate = self
                picker.allowsEditing = true
                
                self.present(picker, animated: false, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        guard self.contents.text.isEmpty == false else{
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.setValue(alertV, forKey: "contentViewController")
            self.present(alert, animated: true)
            return
        }
        
        let contents = self.contents.text
        let array = contents?.split(separator: "\n")
        let content = array![1] as NSString
        let length = ((content.length > 30) ? 30 : content.length)
        
        let data = MemoData()
       
        
        data.title = self.subject
        data.contents = content.substring(with: NSRange(location: 0, length: length))
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts, animations: {
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        })
    }
   
    
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: _NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
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



extension MemoFormVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage

        picker.dismiss(animated: false, completion: nil)
    }
    
    
}
