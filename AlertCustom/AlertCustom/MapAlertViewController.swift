//
//  MapAlertViewController.swift
//  AlertCustom
//
//  Created by 이영우 on 2021/01/17.
//

import UIKit
import MapKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alertBtn = UIButton(type: .system)
        
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(alertBtn)
        // Do any additional setup after loading the view.
    }
    

    @objc func mapAlert(_ sender: UIButton){
        let alert = UIAlertController(title: nil, message: "여기가 맞습니까?", preferredStyle: .alert)
        
        let contentVC = MapKitViewController()
//        let mapKitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        contentVC.view = mapKitView
//        contentVC.preferredContentSize.height = 200
//
//        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
//        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        let region = MKCoordinateRegion(center: pos, span: span)
//
//        mapKitView.region = region
//        mapKitView.regionThatFits(region)
//
//        let point = MKPointAnnotation()
//        point.coordinate = pos
//        mapKitView.addAnnotation(point)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.setValue(contentVC, forKey: "contentViewController")
        
        self.present(alert, animated: false)
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
