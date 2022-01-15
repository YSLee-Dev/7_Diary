//
//  StarViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2022/01/15.
//

import UIKit

class StarViewController: UIViewController {

    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .null, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    private var diaryList = [Diary]()
    var cellId = "cell"
    
    override func viewDidLoad() {
        viewSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDiaryList()
    }
    
    private func loadDiaryList(){
        guard let data = UserDefaults.standard.value(forKey: "diaryList") as? [[String :Any]] else {return}
        self.diaryList = data.compactMap{
            guard let star = $0["star"] as? Bool else {return nil}
            
            if star {
                guard let title = $0["title"] as? String else {return nil}
                guard let contents = $0["contents"] as? String else {return nil}
                guard let date = $0["date"] as? Date else {return nil}
                
                return Diary(title: title, contents: contents, date: date, star: star)
            }else{
                return nil
            }
        }.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
    
    private func viewSet(){
        self.title = "즐겨찾기"
        self.view.backgroundColor = .white
        
        self.collectionView.register(StarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: (self.navigationController?.systemMinimumLayoutMargins.leading)!),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -(self.navigationController?.systemMinimumLayoutMargins.trailing)!)
        ])
    }
    
    private func datetoString(date:Date)->String{
        let formmater = DateFormatter()
        formmater.locale = Locale(identifier: "ko-KR")
        formmater.dateFormat = "yy.MM.dd | EEEEE"
        
        return formmater.string(from: date)
    }
}

extension StarViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AddV = AddViewController()
        AddV.viewMode = .edit(indexPath, self.diaryList[indexPath.row])
       
        self.navigationController?.pushViewController(AddV, animated: true)
    }
}

extension StarViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? StarCollectionViewCell else {return UICollectionViewCell()}
        cell.title.text = self.diaryList[indexPath.row].title
        cell.date.text = datetoString(date: self.diaryList[indexPath.row].date)
        
        return cell
    }
}

extension StarViewController : UICollectionViewDelegateFlowLayout{
    // 셀의 사이즈 결
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - (self.navigationController?.systemMinimumLayoutMargins.leading)! * 2, height: 100)
    }
}
