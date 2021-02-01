//
//  MemoListVC.swift
//  MyMemory
//
//  Created by 이영우 on 2021/01/08.
//

import UIKit

class MemoListVC: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let revealVC = self.revealViewController(){
            let btn = UIBarButtonItem()
            
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            
            self.navigationItem.leftBarButtonItem = btn
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        
        if ud.bool(forKey: UserInfoKey.tutorial) == false{
            let vc = self.instanceTutorialVC(name: "MasterVC")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false, completion: nil)
            return
        }
        self.tableView.reloadData()
    }//화면이 나타날 때마다 호출되는 메소드
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.appDelegate.memolist[indexPath.row]
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MemoCell
        
        cell?.subject?.text = row.title
        cell?.contents?.text = row.contents
        cell?.img?.image = row.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell?.regdate?.text = formatter.string(from: row.regdate!)
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.memolist[indexPath.row]
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else{
            return
        }
        
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
