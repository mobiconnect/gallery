//
//  MKMapViewExtention.swift
//  FishSmart
//
//  Created by Mobiddiction on 22/10/18.
//  Copyright © 2018 mobiddiction. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewDelegate:class{
    func mapPinSelected(_ annotation:MapsAnnotation)
}

class MapView:MKMapView{
    var rangeDistance:Double = 25000.0
    var showPopUpView:Bool = true
    var mapDelegate:MapViewDelegate?
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    func zoomToLocation(_ location:CLLocation){
        self.showsUserLocation = true
        let coordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region=MKCoordinateRegion.init(center: coordinates,latitudinalMeters: rangeDistance,longitudinalMeters: rangeDistance)
        self.setRegion(region, animated: true)
    }

    func loadLocations(_ locations:[Location]){
        var pins:[MapsAnnotation] = []
        for location in locations{
            let center=CLLocationCoordinate2D(latitude: location.lat!, longitude:location.lon!)
            let annotation=MapsAnnotation(info_id:location.id!,title: location.name, mapPin:"map-pin",coordinate: center)
            pins.append(annotation)
        }        
        self.addAnnotations(pins)
        if locations.count == 1{
            zoomToLocation(CLLocation(latitude: locations[0].lat!, longitude:locations[0].lon!))
        }else{
            zoomToPinArea()
        }
    }
    
    func zoomToPinArea(){
        let overlays : [MKOverlay] = self.overlays
        let annotations : [MKAnnotation] = self.annotations
        
        var flyTo = MKMapRect.null
        for overlay in overlays {
            if (flyTo.isNull) {
                flyTo = overlay.boundingMapRect
            } else {
                flyTo = flyTo.union(overlay.boundingMapRect)
            }
        }
        
        let mapEdgePadding = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
        for index in 0..<annotations.count {
            let annotation = annotations[index]
            let aPoint:MKMapPoint = MKMapPoint(annotation.coordinate)
            let rect:MKMapRect = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
            
            if flyTo.isNull {
                flyTo = rect
            } else {
                flyTo = flyTo.union(rect)
            }
        }
        self.setVisibleMapRect(flyTo, edgePadding: mapEdgePadding, animated: true)
    }
}

extension MapView:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        
        if annotation is MapsAnnotation{
            let identifier = "FishSmartAnnotationView"
            var annotationView = self.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
            if annotationView != nil{
                annotationView?.location=annotation as? MapsAnnotation
                annotationView?.annotation=annotation
            }else{
                annotationView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.location=annotation as? MapsAnnotation
                annotationView?.annotation=annotation
            }
            let pin = annotation as? MapsAnnotation
            let pinImage=UIImage(named: (pin?.mapPin)!)
            annotationView?.image=pinImage
            annotationView?.canShowCallout=false
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MapsAnnotation{
            if showPopUpView{
                if let popupView = Bundle.main.loadNibNamed("MapPopupView", owner: self, options: nil)?.first as? MapPopupView {
                    popupView.configureView(annotation)
                    popupView.center = CGPoint(x: view.bounds.size.width*0.5, y: -(popupView.frame.size.height*0.5))
                    view.addSubview(popupView)
                    view.layoutIfNeeded()
                    view.bouncyEffect()
                }
            }else{
                if mapDelegate != nil{
                    self.mapDelegate?.mapPinSelected(annotation)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for subView in view.subviews{
            subView.removeFromSuperview()
        }
    }
}
