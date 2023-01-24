//
//  CreateLocalViewController.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 20/08/21.
//
import MapKit
import SnapKit
import UIKit

class CreateLocalViewController: UIViewController {
    
    private let geocoder = CLGeocoder()
    var coordinatePin = CLLocationCoordinate2D()
    
    weak var mapController: MapViewController?
    
    private let namePlace = MapTextField(mapType: .name, placeholder: "Name")
    private let country = MapTextField(mapType: .country, placeholder: "Country")
    private let city = MapTextField(mapType: .city, placeholder: "City")
    private let street = MapTextField(mapType: .street, placeholder: "Street")
    private let district = MapTextField(mapType: .district, placeholder: "District")
    private let number = MapTextField(mapType: .number, placeholder: "Number")
    
    private let scroolView = UIScrollView()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .dynamicColor(light: .white, dark: .systemGray4)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Location"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Black Regular", size: 16)
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addPin), for: .touchUpInside)
        
        button.backgroundColor = .lightGray
        button.setTitle("+", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        addContainerView()
        addScrollView()
        addTitleLabel()
        addNamePlace()
        addCountry()
        addCity()
        addStreet()
        addDistrict()
        addNumber()
        addRegisterButton()
    }
}

//MARK: - Object
extension CreateLocalViewController {
    @objc func addPin() {
        guard let country = country.textField.text,
              let namePlace = namePlace.textField.text,
              let city = city.textField.text,
              let district = district.textField.text,
              let street = street.textField.text,
              let number = number.textField.text else { return }
        
        let address = "\(country), \(city), \(district), \(street), \(number)"
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                let alert = UIAlertController(title: "Unable to Forward Geocode Address", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            } else {
                var location: CLLocation?
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    let coordinate = location.coordinate
                    let coordinatelocation = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    self.mapController?.createAnnotation(title: namePlace, coordinate: coordinatelocation)
                    self.dismiss(animated: true, completion: nil)

                } else {
                    let alert = UIAlertController(title: "No Matching Location Found", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}

//MARK: - Layout
extension CreateLocalViewController {
    private func addContainerView() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func addScrollView() {
        containerView.addSubview(scroolView)
        scroolView.alwaysBounceVertical = true
        
        scroolView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
    }
    
    private func addTitleLabel() {
        scroolView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalTo(view)
        }
    }
    
    private func addNamePlace() {
        scroolView.addSubview(namePlace)
        
        namePlace.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
    }
    
    private func addCountry() {
        scroolView.addSubview(country)
        
        country.snp.makeConstraints { make in
            make.top.equalTo(namePlace.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
    }
    
    private func addCity() {
        scroolView.addSubview(city)
        
        city.snp.makeConstraints { make in
            make.top.equalTo(country.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
    }
    
    private func addStreet() {
        scroolView.addSubview(street)
        
        street.snp.makeConstraints { make in
            make.top.equalTo(city.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
    }
    
    private func addDistrict() {
        scroolView.addSubview(district)
        
        district.snp.makeConstraints { make in
            make.top.equalTo(street.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view.snp.centerX)
        }
    }
    
    private func addNumber() {
        scroolView.addSubview(number)
        
        number.snp.makeConstraints { make in
            make.top.equalTo(street.snp.bottom).offset(15)
            make.leading.equalTo(district.snp.trailing).offset(4)
            make.trailing.equalTo(view).offset(-30)
        }
    }
    
    private func addRegisterButton() {
        scroolView.addSubview(registerButton)
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(district.snp.bottom).offset(25)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(75)
        }
    }
}
