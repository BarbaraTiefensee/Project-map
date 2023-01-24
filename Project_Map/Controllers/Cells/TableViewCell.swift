//
//  TableViewCell.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 18/08/21.
//
import SnapKit
import UIKit

class TableViewCell: UITableViewCell {

    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabel()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(text: String) {
        label.text = text
    }
}
//MARK: - Layout
extension TableViewCell {
    private func addLabel() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
