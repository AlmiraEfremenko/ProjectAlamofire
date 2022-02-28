//
//  ViewControllerDetail.swift
//  ProjectAlamofire
//
//  Created by MAC on 25.02.2022.
//

import Foundation
import UIKit

class ViewControllerDetail: UIViewController {
    
    private lazy var parentsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var name: UILabel = {
        var name = UILabel()
        name.font = .boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
        private lazy var type: UILabel = {
            var type = UILabel()
            type.font = .systemFont(ofSize: 15)
            type.translatesAutoresizingMaskIntoConstraints = false
            return type
        }()
    
    private lazy var text: UILabel = {
        var text = UILabel()
        text.font = .systemFont(ofSize: 15)
        text.textAlignment = .center
        text.contentMode = .scaleToFill
        text.numberOfLines = 0
        
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageUrl: UIImageView = {
        var imageUrl = UIImageView()
        imageUrl.translatesAutoresizingMaskIntoConstraints = false
        
        return imageUrl
    }()
    
    var cardItems: Card? {
        didSet {
            self.name.text = cardItems?.name
            self.type.text = cardItems?.type
            self.text.text = cardItems?.text
            
            
            guard let imagePath = cardItems?.imageUrl,
                  let imageUrl = URL(string: imagePath),
                  let imageData = try? Data(contentsOf: imageUrl)
            else {
                self.imageUrl.image = UIImage(named: "card")
                return
            }
           
                self.imageUrl.image = UIImage(data: imageData)
            
           
               
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupHierarchy()
        setupLayout()
        
    }
    
    private func setupHierarchy() {
        view.addSubview(parentsStackView)
        parentsStackView.addSubview(name)
        parentsStackView.addSubview(type)
        parentsStackView.addSubview(text)
        parentsStackView.addSubview(imageUrl)
       
        
    }
    
    private func setupLayout() {
     
        parentsStackView.translatesAutoresizingMaskIntoConstraints = false
        parentsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        parentsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        parentsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        parentsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        imageUrl.centerXAnchor.constraint(equalTo: parentsStackView.centerXAnchor).isActive = true
        imageUrl.topAnchor.constraint(equalTo: parentsStackView.topAnchor, constant: 7).isActive = true
        
        name.centerXAnchor.constraint(equalTo: parentsStackView.centerXAnchor).isActive = true
        name.topAnchor.constraint(equalTo: imageUrl.bottomAnchor, constant: 30).isActive = true
        
        type.centerXAnchor.constraint(equalTo: parentsStackView.centerXAnchor).isActive = true
        type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30).isActive = true

        text.centerXAnchor.constraint(equalTo: parentsStackView.centerXAnchor).isActive = true
        text.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 30).isActive = true
        text.trailingAnchor.constraint(equalTo: parentsStackView.trailingAnchor, constant: -10).isActive = true
    }

}
