//
//  ListViewController.swift
//  AlertCustom
//
//  Created by 이영우 on 2021/01/17.
//

import UIKit

class ListViewController: UITableViewController {

    var delegate: MapAlertViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 220
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath: indexPath)
    }
    //사용자가 목록을 선택하면 이 메소드가 호출되면서 내부에 작성된 구문을 따라 MapAlertViewController 클래스에 정의된 메소드를 호출하게 된다.
    //이를 통해 ListViewController에서 발생한 이벤트가 MapAlertViewController에까지 전달될 수 있는 경로가 만들어집니다.
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(indexPath.row) 번째 옵션입니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
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
