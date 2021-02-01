//
//  ProfilogineVC.swift
//  MyMemory
//
//  Created by 이영우 on 2021/01/21.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let uinfo = UserInfoManager() // 개인 정보 관리 매니저
    let profileImage = UIImageView()
    let tv = UITableView()
    
    override func viewDidLoad() {
        self.navigationItem.title = "프로필"
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        let bg = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: bg)
        
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width / 2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width / 2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        self.view.addSubview(bgImg)
        
        self.view.bringSubviewToFront(self.tv)
        self.view.bringSubviewToFront(self.profileImage)
        
//        let image = UIImage(named: "account.jpg")
        let image = self.uinfo.profile//프로필 사진에 들어갈 기본이미지
        
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 270)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        self.view.addSubview(profileImage)
        
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        
        self.tv.delegate = self
        self.tv.dataSource = self
    
        self.view.addSubview(tv)
        
        self.navigationController?.navigationBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true
        
        self.drawBtn()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row{
        case 0:
            cell.textLabel?.text = "이름"
//            cell.detailTextLabel?.text = "꼼곰한 재은씨"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login please"
        case 1:
            cell.textLabel?.text = "계정"
//            cell.detailTextLabel?.text = "sqlpro@naver.com"
            cell.detailTextLabel?.text = self.uinfo.account ?? "Login please"
        default:
            ()
            
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.uinfo.isLogin == false{
            self.doLogin(self.tv)
            //로그인되어 있지 않다면 로그인 창을 띄워 준다.
            
        }
    }
    @objc func close(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func doLogin(_ sender: Any){
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)
        
        loginAlert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "Your Account"
        })
        
        loginAlert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true
        })
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive, handler: { (_) in
            let account = loginAlert.textFields?[0].text ?? "" // 첫 번째 빌드 : 채점
            let passwd = loginAlert.textFields?[1].text ?? "" // 두 번째 필드 : 비밀번호
            
            if self.uinfo.login(account: account, passwd: passwd){
                //로그인 성공시 처리 내용
                self.tv.reloadData()//테이블 뷰를 갱신한다
                self.profileImage.image = self.uinfo.profile // 이미지 프로필을 갱신한다
                self.drawBtn() //로그인 상태에 따라서 로그인/로그아웃 버튼을 출력하자
            } else{
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert , animated: false)
            }
            
        }))
        
        self.present(loginAlert, animated: false)
    }
    
    @objc func doLogout(_ sender: Any){
        let msg = "로그아웃하시겠습니가?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { (_) in
            if self.uinfo.logout(){
                //로그아웃시 처리할 내용이 여기에 들어갈 예정입니다.
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()//로그인 상태에 따라 적절히 로그인/로그아웃 버튼을 출력한다.
            }
        }))
        self.present(alert, animated: false)
    }
    
    func drawBtn(){
        let v = UIView()
        v.frame.size.width = self.view.frame.width
        v.frame.size.height = 40
        v.frame.origin.x = 0
        v.frame.origin.y = self.tv.frame.origin.y + self.tv.frame.height
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        self.view.addSubview(v)
        
        let btn = UIButton(type: .system)
        btn.frame.size.width = 100
        btn.frame.size.height = 30
        btn.center.x = v.frame.size.width / 2
        btn.center.y = v.frame.size.height / 2
        
        //로그인 상태일 때는 로그아웃 버튼을, 로그아웃 상태일 때에는 로그인 버튼을 만들어 준다.
        
        if self.uinfo.isLogin == true{
            btn.setTitle("로그아웃", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        } else{
            btn.setTitle("로그인", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        
        v.addSubview(btn)
    }
    
    func imgPicker(_ source: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.uinfo.profile = img
            self.profileImage.image = img
        }
        //이 구문을 누락하면 이미지 피커 컨트롤러 창이 닫히지 않는다.
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func profile(_ sender: UIButton){
        //로그인 되어 있지 않을 경우에는 프로필 이미지 등록을 막고 대신 로그인 창을 띄워주자!!
        guard self.uinfo.account != nil else{
            self.doLogin(self)
            return
        }
        
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해 주세요", preferredStyle: .actionSheet)
        
        // 카메라를 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (_) in
                self.imgPicker(.camera)
            }))
        }
        
        //저장된 앨범을 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            alert.addAction(UIAlertAction(title: "저장된 앨범", style: .default, handler: { (_) in
                self.imgPicker(.savedPhotosAlbum)
            }))
        }
        
        //포토 라이브러리를 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            alert.addAction(UIAlertAction(title: "저장된 앨범", style: .default, handler: { (_) in
                self.imgPicker(.photoLibrary)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        //취소 버튼 추가
        
        self.present(alert, animated: true, completion: nil)
        //액션 시트 창 실행
    }
}
