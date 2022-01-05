//
//  CollectionViewCell.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/11.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    var date:UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 13)
        date.textAlignment = .right
        date.numberOfLines = 1
        date.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return date
    }()
    
    func set(){
        self.addSubview(self.title)
        self.addSubview(self.date)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            self.date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.title.trailingAnchor.constraint(equalTo: self.date.leadingAnchor),
            
            self.date.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.date.leadingAnchor.constraint(equalTo: self.title.trailingAnchor),
        ])
    }
}
