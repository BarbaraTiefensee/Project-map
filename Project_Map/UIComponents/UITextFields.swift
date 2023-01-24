//
//  UITextFields.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 21/08/21.
//
import UIKit
import Foundation

enum MapType {
    case none
    case name
    case country
    case city
    case district
    case street
    case number
}

class MapTextField: UIView {
    private let placeHolder: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .dynamicColor(light: .black, dark: .white)
        
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.dynamicColor(light: .black, dark: .white).cgColor
        return textField
    }()
    
    private let type: MapType
    
    init(mapType: MapType = .none, placeholder: String? = nil) {
        self.type = mapType
        self.placeHolder.text = placeholder
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addPlaceholder()
        addTextField()
        
        switch type {
        case .name:
            spaceOnTextField()
        case .country:
            spaceOnTextField()
        case .city:
            spaceOnTextField()
        case .district:
            spaceOnTextField()
        case .street:
            spaceOnTextField()
        case .number:
            spaceOnTextField()
        default:
            break
        }
    }
}

extension MapTextField {
    private func addPlaceholder(){
        addSubview(placeHolder)
        
        placeHolder.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    private func addTextField() {
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(placeHolder.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    private func spaceOnTextField() {
        let paddingViewRight = UIView()
        paddingViewRight.frame = CGRect(x: 0, y: 0, width: 10, height: 45)
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = paddingViewRight
        
        let paddingViewLeft = UIView()
        paddingViewLeft.frame = CGRect(x: 0, y: 0, width: 15, height: 45)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = paddingViewLeft
    }
}
