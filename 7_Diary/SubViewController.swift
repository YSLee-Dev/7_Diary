//
//  SubViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/08.
//

import UIKit

class SubViewController : UIViewController{
    
    var cellId = "SubCell"
    
    var collectionView : UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .null, collectionViewLayout: flow)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.collectionView.register(SubCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
