//
//  ViewController.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 18/08/21.
//
import SnapKit
import UIKit
import MapKit

class LocalViewController: UIViewController {
    
    private let map = MapViewController()
    private let tableView = UITableView()
    private let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Location"
        
        setup()
    }
    
    func setup() {
        addTableView()
    }
}

//MARK: - Layout
extension LocalViewController {
    private func addTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .white
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

//MARK: - Delegate
extension LocalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return map.annotationsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        guard let caisatation = map.annotationsArray[indexPath.row].title else { return UITableViewCell() }
        cell.setup(text: caisatation)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.map.showAnnotation()
        dismiss(animated: true, completion: nil)
    }
}
