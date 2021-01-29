//
//  ListViewController.swift
//  Plist
//
//  Created by 이영우 on 2021/01/28.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    //결혼 여부
    
    var defaultPList: NSDictionary!
    //메인 번들에 정의된 PList 내용을 저정할 딕셔너리
    var accountlist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        
        picker.delegate = self
        self.account.inputView = picker
        //account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 25)
        toolbar.barTintColor = .lightGray
        self.account.inputAccessoryView = toolbar
        //액세서리 뷰 영역에 틀 바를 표시
        
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        toolbar.setItems([done], animated: true)
        //버튼을 툴 바에 표시한다.
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, done], animated: true)
        
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        toolbar.setItems([new, flexSpace, done], animated: true)
        //버튼을 툴 바에 추가
        
        let plist = UserDefaults.standard
        //기본 저장소 객체 불러오기
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        //위에 세줄은 왜 있는지 모르겠다. 지울까?
        
        
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        
        if let account = plist.string(forKey: "selectedAccount"){ //"selectedAccount" 키에 저장된 값이 있으면, 이를 사용하여 읽어와야 할 파일의 이름을 구성한다.
            
            self.account.text = account
            let customPlist = "\(account).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)// 2-1
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false // 6
            
        }
        
        if(self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다"
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
        
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist"){
            self.defaultPList = NSDictionary(contentsOfFile: defaultPListPath)
        }
    }

    @IBAction func changeGender(_ sender: UISegmentedControl){
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
        
//        let plist = UserDefaults.standard
//        plist.setValue(value, forKey: "gender")
//        plist.synchronize()//동기화 처리
        
        let customPlist = "\(self.account.text!).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
        
    }
    
    @IBAction func changeMarried(_ sender: UISwitch){
        let value = sender.isOn//true이면 기혼, false이면 미혼
        
//        let plist = UserDefaults.standard
//        plist.setValue(value, forKey: "married")
//        plist.synchronize()
        
        let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("custom plist = \(plist)")
    }
    
    @objc func pickerDone(_ sender: Any){
        self.view.endEditing(true)
        
        if let _account = self.account.text{
            let customPlist = "\(_account).plist" //읽어올 파일명
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    
    @objc func newAccount(_ sender: Any){
        self.view.endEditing(true)//일단 열려있는 입력용 뷰부터 닫아주자
        
        let alert = UIAlertController(title: "새 계정을 입력하자", message: nil, preferredStyle: .alert)
        
        alert.addTextField{
            $0.placeholder = "ex) abc@gmail.com"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let account = alert.textFields?[0].text{
                self.accountlist.append(account)
                self.account.text = account
                
                let plist = UserDefaults.standard
                
                plist.set(self.accountlist, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
                
                self.gender.isEnabled = true
                self.married.isEnabled = true
                //입력 항목을 활성화한다.
            }
        }))
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    //MARK: - PickerView function
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return self.accountlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let account = self.accountlist[row]
        self.account.text = account
        
        let plist = UserDefaults.standard
        plist.setValue(account, forKey: "selectedAccount")
        plist.synchronize()
    }
    
    //MARK: -- TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            alert.addTextField(){
                $0.text = self.name.text // name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
            }
        
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                let value = alert.textFields?[0].text
                
                let customPlist = "\(self.account.text!).plist" //읽어올 파일명
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
                
                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                //동기화 처리
                self.name.text = value
            }))
            
            self.present(alert, animated: false, completion: nil)
        }
    }
}

