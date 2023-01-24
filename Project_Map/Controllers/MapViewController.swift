//
//  MapViewController.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 18/08/21.
//
import SnapKit
import MapKit
import UIKit

class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    
    
    private var annotation = MKPointAnnotation()
    var annotationsArray = [MKPointAnnotation]()
    
    private let viewModel = MapViewModel()
    private var coisa: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController()
        addMapView()
        fetchLocalMap(viewModel.local)
    }
    
    private func navigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigationItemAddTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(navigationItemBookmarksTapped))
    }
    
    func fetchLocalMap(_ local: [Local]) {
        for lugar in local {
            createAnnotation(title: lugar.name, coordinate: lugar.coordinate)
            mapView.region = MKCoordinateRegion(center: lugar.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        }
    }
    
    private func addPin(_ annotation: MKPointAnnotation) {
        let alert = UIAlertController(title: "Local", message: nil, preferredStyle: .alert)
        alert.addTextField { nameText in
            nameText.placeholder = "Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let titleAlert = alert.textFields?[0].text else { return }
            annotation.title = titleAlert
        }
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Objct
extension MapViewController {
    @objc private func mapTappedAdd(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let newAnnotation = MKPointAnnotation()
            let coordinateTapped = sender.location(in: mapView)
            let coordinate = mapView.convert(coordinateTapped, toCoordinateFrom: mapView)
            newAnnotation.coordinate = coordinate
            addPin(newAnnotation)
            mapView.addAnnotation(newAnnotation)
            annotationsArray.append(newAnnotation)
        }
    }
    
    @objc private func informationPin() {
        let alert = UIAlertController(title: annotation.title, message: nil, preferredStyle: .alert)
        
        let renameAction = UIAlertAction(title: "Rename", style: .default) { action in
            let alertRename = UIAlertController(title: self.annotation.title, message: nil, preferredStyle: .alert)
            alertRename.addTextField { name in
                name.placeholder = "Rename"
            }
            let save = UIAlertAction(title: "Save", style: .default) { action in
                guard let titleName = alertRename.textFields?[0].text else { return }
                self.annotation.title = titleName
            }
            let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            alertRename.addAction(save)
            alertRename.addAction(cancel)
            
            self.present(alertRename, animated: true, completion: nil)
        }
        
        let removeAction = UIAlertAction(title: "Remove", style: .default) { action in
            self.mapView.removeAnnotation(self.annotation)
            
            if let index = self.annotationsArray.firstIndex(of: self.annotation) {
                self.annotationsArray.remove(at: index)
                self.mapView.removeAnnotation(self.annotation)
            }
        }
        
        alert.addAction(renameAction)
        alert.addAction(removeAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func addPointLocal() {
        let view = CreateLocalViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc private func navigationItemAddTapped() {
        let viewController = CreateLocalViewController()
        viewController.mapController = self
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func navigationItemBookmarksTapped() {
        let viewController = LocalViewController()
        present(viewController, animated: true, completion: nil)
    }
}

//MARK: - Layout
extension MapViewController {
    private func addMapView() {
        view.addSubview(mapView)
        
        let gestureAdd = UILongPressGestureRecognizer(target: self, action: #selector(mapTappedAdd))
        gestureAdd.minimumPressDuration = 1
        gestureAdd.delaysTouchesBegan = true
        
        mapView.delegate = self
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        mapView.addGestureRecognizer(gestureAdd)
        
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: - Delegate
extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(informationPin), for: .touchUpInside)
        
        let identifier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.rightCalloutAccessoryView = button
            annotationView?.canShowCallout = true
            let location = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            mapView.setCenter(location, animated: true)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationView = view.annotation as? MKPointAnnotation else { return }
        self.annotation = annotationView
    }
    
}

//MARK: = ViewModelDelegate
extension MapViewController: MapViewModelDelegate {
    
    func createAnnotation(title: String?, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func showAnnotation() {
        let location = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        mapView.setCenter(location, animated: true)
    }
}
