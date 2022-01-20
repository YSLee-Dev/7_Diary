//
//  ViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/07.
//

import UIKit

class ViewController: UIViewController {
    
    private var cellId = "cell"
    private var diaryList = [Diary](){
        didSet {
            self.saveData()
        }
    }

    var collectionView : UICollectionView = {
        
        var flow = UICollectionViewFlowLayout()
        
        var cv = UICollectionView(frame: .null, collectionViewLayout: flow)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        viewSet()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NCEdit(_:)), name: NSNotification.Name("editDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(starSelect(_:)), name: NSNotification.Name("starDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteDiary(_:)), name: NSNotification.Name("deleteDiary"), object: nil)
    }
    
    
    private func viewSet(){
        self.view.addSubview(self.collectionView)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.navigationItem.title = "일기장"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "일기작성", style: .done, target: self, action: #selector(addBtnClick))
        
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
        formmater.dateFormat = "yy.MM.dd | EEEEE"
        
        return formmater.string(from: date)
    }
    
    private func saveData(){
        let data = self.diaryList.map{
            [
                "uuid" : $0.uuid,
                "title":$0.title,
                "contents":$0.contents,
                "star":$0.star,
                "date":$0.date
            ]
        }
        let ud = UserDefaults.standard
        ud.setValue(data, forKey: "diaryList")
    }
    
    private func loadData(){
        let ud = UserDefaults.standard
        guard let data = ud.value(forKey: "diaryList") as? [[String:Any]] else{  return }
        self.diaryList = data.compactMap{
            guard let uuid = $0["uuid"] as? String else{return nil}
            guard let title = $0["title"] as? String else{return nil}
            guard let contents = $0["contents"] as? String else{return nil}
            guard let star = $0["star"] as? Bool else{return nil}
            guard let date = $0["date"] as? Date else{return nil}
            
            return Diary(uuid: uuid, title: title, contents: contents, date: date, star: star)
        }
        self.diaryList = diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
    }
    
    @objc func addBtnClick(){
        let addC = AddViewController()
        addC.delegate = self
        self.navigationController?.pushViewController(addC, animated: true)
    }
    
    // 수정사항 저장
    @objc private func NCEdit(_ NC:Notification){
        guard let ncDiary = NC.object as? Diary else {return}
        guard let index = self.diaryList.firstIndex(where: {
            $0.uuid == ncDiary.uuid
        }) else {return}
        
        self.diaryList[index] = ncDiary
        self.diaryList = diaryList.sorted{
            $0.date.compare($1.date) == .orderedDescending
        }
        self.collectionView.reloadData()
    }
    
    // 즐겨찾기 저장
    @objc func starSelect(_ NC: Notification) {
        guard let data = NC.object as? [String:Any] else {return}
        guard let uuid = data["uuid"] as? String else {return}
        guard let star = data["star"] as? Bool else {return}
        
        guard let index = self.diaryList.firstIndex(where: {
            $0.uuid == uuid
        }) else {return}
        
        self.diaryList[index].star = star
    }
    
    // 다이어리 삭제
    @objc func deleteDiary(_ NC : Notification) {
        guard let uuid = NC.object as? String else {return}
        guard let index = self.diaryList.firstIndex(where: {
            $0.uuid == uuid
        }) else {return}
        
        self.diaryList.remove(at: index)
        self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
}

// 다이어리 추가
extension ViewController : AddDiaryDelegate{
    func valueRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.diaryList = diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
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
extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AddV = AddViewController()
        AddV.viewMode = .edit(indexPath, self.diaryList[indexPath.row])
        AddV.delegate = self
       
        self.navigationController?.pushViewController(AddV, animated: true)
    }
}

// 컬렉션 뷰의 셀 위치? 관리
extension ViewController:UICollectionViewDelegateFlowLayout{
    
    // 셀의 사이즈 결
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - ((self.navigationController?.systemMinimumLayoutMargins.leading)! * 2), height: 50)
    }
}
