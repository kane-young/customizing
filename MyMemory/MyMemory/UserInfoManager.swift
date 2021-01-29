//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by 이영우 on 2021/01/29.
//

import UIKit

struct UserInfoKey{
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
}

class UserInfoManager{
    
    var isLogin: Bool{
        if self.loginId == 0 || self.account == nil{
           return false
        } else{
            return true
        }
    }
    
    var loginId: Int{
        get{
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    
    var account: String?{
            get{
                return UserDefaults.standard.string(forKey: UserInfoKey.account)
            }
            
            set(v){
                let ud = UserDefaults.standard
                ud.set(v, forKey: UserInfoKey.account)
                ud.synchronize()
            }
    }
    
    var name: String?{
        get{
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    var profile: UIImage?{
        get{
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile){
                return UIImage(data: _profile)
            } else {
                return UIImage(named: "account.jpg")//이미지가 없다면 기본 이미지로
            }
        }
        
        set(v){
            if v != nil{
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    
    func login(account: String, passwd: String) -> Bool{
        //TODO: 이 부분은 나중에 서버와 연동되는 코드로 대체될 예정입니다.
        if account.isEqual("sqlpro@naver.com") && passwd.isEqual("1234"){
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("재은 씨", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        } else{
            return false
        }
    }
    
    func logout() -> Bool{
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
        
    }
}//계정 및 사용자 정보를 저장 관리하는 클래스
