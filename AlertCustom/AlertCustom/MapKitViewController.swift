//
//  MapKitViewController.swift
//  AlertCustom
//
//  Created by 이영우 on 2021/01/17.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = mapkitView
        self.preferredContentSize.height = 200
        
        //표시할 위치
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)

        //지도가 보여줄 넓이, 일종의 축척, 숫자가 작을수록 좁은 범위를 확대시켜 보여준다.
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        //지도 영역을 정의
        let region = MKCoordinateRegion(center: pos, span: span)
        
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
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
