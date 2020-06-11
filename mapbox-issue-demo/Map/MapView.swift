//
//  MapView.swift
//  mapbox-issue-demo
//
//  Created by Rustam G on 11.06.2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Mapbox
import SwiftUI

struct MapView: UIViewRepresentable {

    func makeUIView(context: Context) -> ZonesMapWrappedView {

        let wrappedMapView = ZonesMapWrappedView()

        return wrappedMapView
    }

    func updateUIView(_ uiView: ZonesMapWrappedView, context: Context) {

    }
}

class ZonesMapWrappedView: UIView {

    weak private(set) var mapView: MGLMapView?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    private func setupView() {

        let mapView = MGLMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.centerCoordinate = defaultMapLocation
        mapView.zoomLevel = defaultMapZoomLevel
        mapView.delegate = self
        addSubview(mapView)
        self.mapView = mapView

        // delay to emulate loading from external soure
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            mapView.addAnnotation(ZoneMapAnnotation(zoneId: "1", title: "Idaho", bubbleColor: .gray, coordinate: CLLocationCoordinate2D(latitude: 44.42107773488257, longitude: -114.69200439839581)))
            mapView.addAnnotation(ZoneMapAnnotation(zoneId: "2", title: "LA", bubbleColor: .darkGray, coordinate: CLLocationCoordinate2D(latitude: 34.05374916172564, longitude: -118.24868457816989)))
            mapView.addAnnotation(ZoneMapAnnotation(zoneId: "3", title: "Foo", bubbleColor: .red, coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 34)))
            mapView.addAnnotation(ZoneMapAnnotation(zoneId: "4", title: "SBD", bubbleColor: .green, coordinate: CLLocationCoordinate2D(latitude: 34.09599673372184, longitude: -117.23458703266625)))
        }
    }
}

let defaultMapLocation = CLLocationCoordinate2D(latitude: 33.9415889, longitude: -118.4107187)
let defaultMapZoomLevel: Double = 5

extension ZonesMapWrappedView: MGLMapViewDelegate {

    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {

        guard let annotation = annotation as? ZoneMapAnnotation else {
            return nil
        }

        let reuseIdentifier = "ZoneMapAnnotation"
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? ZoneMapAnnotationView
            ?? ZoneMapAnnotationView(
                  annotation: annotation, reuseIdentifier: reuseIdentifier
            )

        annotationView.bubbleColor = annotation.bubbleColor
        annotationView.text = annotation.title ?? ""

        return annotationView
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        guard let zoneAnnotation = annotation as? ZoneMapAnnotation else {
            return
        }
        print("Annotation selected \(zoneAnnotation)")
    }
    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
        print("Annotation view selected")
    }
}
