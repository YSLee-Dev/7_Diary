//
//  ViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/07.
//

import UIKit

class ViewController: UIViewController {
    
    var cellId = "cell"

    var collectionView : UICollectionView = {
        
        var flow = UICollectionViewFlowLayout()
        
        var cv = UICollectionView(frame: .null, collectionViewLayout: flow)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        
        self.navigationItem.title = "일기장"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "일기추가", style: .done, target: self, action: #selector(addBtnClick))
        
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func addBtnClick(){
        let addC = AddViewController()
        self.navigationController?.pushViewController(addC, animated: true)
    }
}

