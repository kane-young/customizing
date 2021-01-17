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
        
        let imageBtn = UIButton(type: .system)
        imageBtn.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        imageBtn.center.x = self.view.frame.width / 2
        imageBtn.setTitle("Image Alert", for: .normal)
        imageBtn.addTarget(self, action: #selector(imageAlert(_ : )), for: .touchUpInside)
        
        self.view.addSubview(imageBtn)
        // Do any additional setup after loading the view.
        
        let sliderBtn = UIButton(type: .system)
        sliderBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        sliderBtn.center.x = self.view.frame.width / 2
        sliderBtn.setTitle("Slider Alert", for: .normal)
        sliderBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)

        self.view.addSubview(sliderBtn)
        
        let listBtn = UIButton(type: .system)
        listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        listBtn.center.x = self.view.frame.width / 2
        listBtn.setTitle("List Alert", for: .normal)
        listBtn.addTarget(self, action: #selector(listAlert(_ : )), for: .touchUpInside)
        
        self.view.addSubview(listBtn)
    }
    
    
    @objc func listAlert(_ sender: Any){
        let contentVC = ListViewController()
        contentVC.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.setValue(contentVC, forKey: "contentViewController")
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: false)
    }
    
    
    @objc func sliderAlert(_ sender: Any){
        let contentVC = ControlViewController()
        let alert = UIAlertController(title: nil, message: "이번 글의 평점을 입력해주세요.", preferredStyle: .alert)
        alert.setValue(contentVC, forKey: "contentViewController")
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            print(">>> sliderValue = \(contentVC.sliderValue)")
        })
        alert.addAction(okAction)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    @objc func imageAlert(_ sender: Any){
        let alert = UIAlertController(title: nil, message: "이번 글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKey: "contentViewController")
        
        self.present(alert, animated: false, completion: nil)
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
    
    func didSelectRowAt(indexPath: IndexPath){
        print(">>> 선택된 행은 \(indexPath.row)")
    }

    
    
}
