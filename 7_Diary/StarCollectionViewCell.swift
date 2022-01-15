//
//  StarCollectionViewCell.swift
//  7_Diary
//
//  Created by 이윤수 on 2022/01/15.
//

import UIKit

class StarCollectionViewCell: UICollectionViewCell {
    
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
        date.textAlignment = .center
        date.numberOfLines = 1
        return date
    }()
    
    var bold : UIView = {
        let bold = UIView()
        bold.backgroundColor = .gray
        bold.translatesAutoresizingMaskIntoConstraints = false
        return bold
    }()
    
    func set(){
        self.addSubview(self.title)
        self.addSubview(self.bold)
        self.addSubview(self.date)
        
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.gray.cgColor
        
        NSLayoutConstraint.activate([
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15),
            
            self.date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.date.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.bold.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.bold.heightAnchor.constraint(equalToConstant: 0.5),
            self.bold.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.bold.bottomAnchor.constraint(equalTo: self.date.topAnchor, constant: -10)
        ])
    }
}
