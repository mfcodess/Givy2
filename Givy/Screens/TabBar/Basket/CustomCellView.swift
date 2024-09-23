//
//  CustomCellView.swift
//  Givy
//
//  Created by Max on 18.08.2024.
//

import UIKit

class CustomCellView: UITableViewCell {
    
    let customCell = CustomCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTableViewCell() {
        contentView.addSubview(customCell)
        customCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            customCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
