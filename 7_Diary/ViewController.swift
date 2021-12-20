//
//  ViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/07.
//

import UIKit

class ViewController: UIViewController {
    
    private var cellId = "cell"
    private var diaryList = [Diary]()

    var collectionView : UICollectionView = {
        
        var flow = UICollectionViewFlowLayout()
        
        var cv = UICollectionView(frame: .null, collectionViewLayout: flow)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        viewSet()
        addDiary()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func viewSet(){
        self.view.addSubview(self.collectionView)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.navigationItem.title = "일기장"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "일기추가", style: .done, target: self, action: #selector(addBtnClick))
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func datetoString(date:Date)->String{
        let formmater = DateFormatter()
        formmater.locale = Locale(identifier: "ko-KR")
        formmater.dateFormat = "yyyy.MM.dd(EEEEE)"
        
        return formmater.string(from: date)
    }
    
    private func addDiary(){
        let addVC = AddViewController()
        addVC.delegate = self
    }
    
    @objc func addBtnClick(){
        let addC = AddViewController()
        self.navigationController?.pushViewController(addC, animated: true)
    }
}

// 다이어리 추가
extension ViewController : AddDiaryDelegate{
    func valueRegister(diary: Diary) {
        self.diaryList.append(diary)
    }
}

// 컬렉션 뷰의 데이터 관리
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 섹션의 개수
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        let diary = self.diaryList[indexPath.row]
        cell.title.text = diary.title
        cell.date.text = self.datetoString(date: diary.date)
        
        return cell
    }
    
    
}
extension ViewController :UICollectionViewDelegate{
    
}

// 컬렉션 뷰의 셀 위치? 관리
extension ViewController:UICollectionViewDelegateFlowLayout{
    
}
