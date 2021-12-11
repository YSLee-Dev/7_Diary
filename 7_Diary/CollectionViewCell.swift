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
    
    func set(){
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textAlignment = .center
        title.numberOfLines = 1
        
        self.addSubview(title)
        
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 13)
        date.textAlignment = .left
        date.numberOfLines = 1
        
        self.addSubview(date)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            title.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            date.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            date.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
