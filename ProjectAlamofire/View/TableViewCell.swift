//
//  TableViewCell.swift
//  ProjectAlamofire
//
//  Created by MAC on 24.02.2022.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    private lazy var name: UILabel = {
        var name = UILabel()
        name.font = .systemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var type: UILabel = {
        var type = UILabel()
        type.font = .systemFont(ofSize: 15)
        type.translatesAutoresizingMaskIntoConstraints = false
        return type
    }()
    
    private lazy var imageUrl: UIImageView = {
        var imageUrl = UIImageView()
        imageUrl.translatesAutoresizingMaskIntoConstraints = false
        return imageUrl
    }()
    
    var card: Card? {
        didSet {
            self.name.text = card?.name
            self.type.text = card?.type
            
            guard let imagePath = card?.imageUrl,
                  let imageUrl = URL(string: imagePath),
                  let imageData = try? Data(contentsOf: imageUrl)
            else {
                self.imageUrl.image = UIImage(named: "card")
                return
            }
            
            self.imageUrl.image = UIImage(data: imageData)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(name)
        contentView.addSubview(type)
        contentView.addSubview(imageUrl)
    }
    
    private func setupLayout() {
        imageUrl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imageUrl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageUrl.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageUrl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        name.leadingAnchor.constraint(equalTo: imageUrl.trailingAnchor, constant: 20).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        type.leadingAnchor.constraint(equalTo: imageUrl.trailingAnchor, constant: 20).isActive = true
        type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        type.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
