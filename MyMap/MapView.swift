//
//  MapView.swift
//  MyMap
//
//  Created by 河田佳之 on 2024/03/05.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    // 検索キーワード
    let searchKey: String
    
    // 表示する View を作成するときに実行
    func makeUIView(context: Context) -> MKMapView {
        // MKMapViewのインスタンス生成
        MKMapView()
    }
    
    // 表示した View が更新されるたびに実行
    func updateUIView(_ uiView: MKMapView, context content: Context) {
        // 入力された検索文字
        print(searchKey)
        
        // CLGeocoderインスタンスを取得
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
            // リクエストの結果が存在し、１件目の情報から位置情報を取り出す
            if let unwrapPlacemarks = placemarks,
               let firstPlacemark = unwrapPlacemarks.first,
               let location = firstPlacemark.location {
                // 位置情報から緯度経度をtargetCoordinateに取り出す
                let targetCoordinate = location.coordinate
                
                // 緯度経度をデバッグエリアに表示
                print(targetCoordinate)
                
                // MKPointAnnotatonインスタンスを取得し、ピンを生成
                let pin = MKPointAnnotation()
                
                // ピンを置く場所に緯度経度を設定
                pin.coordinate = targetCoordinate
                
                // ピンのタイトル設定
                pin.title = searchKey
                
                // ピンを地図の置く
                uiView.addAnnotation(pin)
                
                // 緯度経度を中心にして半径500mの範囲を表示
                uiView.region = MKCoordinateRegion(
                    center: targetCoordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0)
            } else {
                print("「\(searchKey)」は見つかりませんでした")
            }
        })
    }
}

#Preview {
    MapView(searchKey: "下神明")
}
