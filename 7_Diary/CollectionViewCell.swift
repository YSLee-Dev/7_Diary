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
        title.textAlignment = .center
        title.numberOfLines = 1
        return title
    }()
    
    var date:UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 13)
        date.textAlignment = .left
        date.numberOfLines = 1
        return date
    }()
    
    func set(){
        self.addSubview(self.title)
        self.addSubview(self.date)
        
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.title.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.date.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            self.date.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
