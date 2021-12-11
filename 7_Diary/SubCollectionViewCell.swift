//
//  SubCollectionViewCell.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/11.
//

import UIKit

class SubCollectionViewCell: UICollectionViewCell {
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
        
        let contents = UILabel()
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.font = UIFont.systemFont(ofSize: 12)
        contents.textAlignment = .left
        contents.numberOfLines = 0
        
        self.addSubview(contents)
        
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 13)
        date.textAlignment = .center
        date.numberOfLines = 1
        
        self.addSubview(date)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            title.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            contents.topAnchor.constraint(equalTo: contents.bottomAnchor, constant: 10),
            contents.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            contents.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            date.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            date.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
