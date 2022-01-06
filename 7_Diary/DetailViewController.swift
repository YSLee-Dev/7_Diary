//
//  DetailViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/18.
//

import UIKit

protocol DetailViewDelegate : AnyObject{
    func dataDelete(PIndexPath : IndexPath)
}

class DetailViewController: UIViewController {
    
    var titleBG : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hue: 0.6083, saturation: 0.72, brightness: 0.35, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    var titleTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.attributedPlaceholder = NSAttributedString(string: "제목을 입력하세요.",attributes: [NSAttributedString.Key.foregroundColor :  UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0)])
        tf.textColor = .white
        tf.layer.cornerRadius = 15
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.smartQuotesType = .no
        tf.smartDashesType = .no
        tf.smartInsertDeleteType = .no
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var contentsBG : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(hue: 0.0778, saturation: 0, brightness: 0.95, alpha: 1.0)
        return view
    }()
    
    var contentsTV : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 15
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.spellCheckingType = .no
        tv.smartQuotesType = .no
        tv.smartDashesType = .no
        tv.smartInsertDeleteType = .no
        tv.isEditable = false
        tv.backgroundColor = UIColor(hue: 0.0778, saturation: 0, brightness: 0.95, alpha: 1.0)
        return tv
    }()
    
    var addScrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    var addStackView : UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fill
        st.spacing = 15
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    var toolBar : UIToolbar = {
        let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let ti = UIBarButtonItem(title: "닫기", style: .done, target: self, action: nil)
        tb.sizeToFit()
        tb.setItems([ti], animated: true)
        return tb
    }()
    
    var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var editBtn : UIBarButtonItem?
    var deleteBtn : UIBarButtonItem?
    var editOkBtn : UIBarButtonItem?
    
    var detailIndexPath : IndexPath?
    var diary : Diary?
    weak var delegate : DetailViewDelegate?
    
    override func viewDidLoad() {
        viewSetup()
    }
    
    private func viewSetup(){
        self.view.backgroundColor = .white
        
        self.editBtn = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editBtnClick(_:)))
        self.deleteBtn = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteBtnClick(_:)))
        self.editOkBtn = UIBarButtonItem(title: "수정완료", style: .plain, target: self, action: #selector(editOkBtnClick(_:)))
        
        self.navigationItem.setRightBarButtonItems([self.editBtn!,self.deleteBtn!], animated: true)
        self.navigationItem.rightBarButtonItems![1].tintColor = .red
        
        self.titleTF.text = self.diary?.title
        self.contentsTV.text = self.diary?.contents
        self.title = dateToString(date: self.diary!.date)
        
        let margin = (self.navigationController?.systemMinimumLayoutMargins.leading)! * 2
        
        self.view.addSubview(self.addScrollView)
        NSLayoutConstraint.activate([
            self.addScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.addScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.addScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.addScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.addScrollView.addSubview(self.addStackView)
        NSLayoutConstraint.activate([
            self.addStackView.widthAnchor.constraint(equalTo: self.addScrollView.widthAnchor, constant: -margin),
            self.addStackView.topAnchor.constraint(equalTo: self.addScrollView.topAnchor),
            self.addStackView.centerXAnchor.constraint(equalTo: self.addScrollView.centerXAnchor),
            self.addStackView.bottomAnchor.constraint(equalTo: self.addScrollView.bottomAnchor)
        ])
        
        self.addStackView.addArrangedSubview(self.titleBG)
        NSLayoutConstraint.activate([
            self.titleBG.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.titleBG.addSubview(self.titleTF)
        self.titleTF.inputAccessoryView = self.toolBar
        NSLayoutConstraint.activate([
            self.titleTF.bottomAnchor.constraint(equalTo: self.titleBG.bottomAnchor),
            self.titleTF.heightAnchor.constraint(equalTo: self.titleBG.heightAnchor),
            self.titleTF.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.titleTF.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10),
        ])
        
        self.addStackView.addArrangedSubview(self.contentsBG)
        NSLayoutConstraint.activate([
            self.contentsBG.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)
        ])
        
        self.contentsBG.addSubview(self.contentsTV)
        self.contentsTV.inputAccessoryView = self.toolBar
        NSLayoutConstraint.activate([
            self.contentsTV.bottomAnchor.constraint(equalTo: self.contentsBG.bottomAnchor),
            self.contentsTV.topAnchor.constraint(equalTo: self.contentsBG.topAnchor),
            self.contentsTV.leadingAnchor.constraint(equalTo: self.contentsBG.leadingAnchor, constant: 5),
            self.contentsTV.trailingAnchor.constraint(equalTo: self.contentsBG.trailingAnchor, constant: -5),
        ])
    }
    
    func dateToString(date : Date) -> String{
        let Formatter = DateFormatter()
        Formatter.dateFormat = "YY.MM.dd | EEE"
        Formatter.locale = Locale(identifier: "ko-KR")
        
        return Formatter.string(from: date)
    }
    
    private func bgViewUp(){
        self.view.addSubview(self.bgView)
        NSLayoutConstraint.activate([
            self.bgView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.bgView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            self.bgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.bgView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func deleteBtnClick(_ sender:Any){
        guard let index = self.detailIndexPath else {return}
        self.delegate?.dataDelete(PIndexPath: index)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editBtnClick(_ sender:Any){
        self.navigationItem.title = "일기수정"
        self.titleTF.isEnabled = true
        self.contentsTV.isEditable = true
        self.navigationItem.rightBarButtonItems![1].isEnabled = false
        self.navigationItem.rightBarButtonItems![1].tintColor = .clear
        self.navigationItem.rightBarButtonItems![0] = self.editOkBtn!
    }
    
    @objc func editOkBtnClick(_ sender:Any){
        bgViewUp()
        self.view.endEditing(true)
        let popup = PopupViewController()
        popup.modalPresentationStyle = .overFullScreen
        popup.delegate = self
        self.present(popup, animated: true)
    }
}

extension DetailViewController : Datasend{
    func data(date: Date) {
        self.bgView.removeFromSuperview()
        self.navigationItem.title = dateToString(date: date)
        
        self.navigationItem.rightBarButtonItems![1].isEnabled = true
        self.navigationItem.rightBarButtonItems![1].tintColor = .red
        self.navigationItem.rightBarButtonItems![0] = self.editBtn!
        
        self.titleTF.isEnabled = false
        self.contentsTV.isEditable = false
    }
    
    func close() {
        self.bgView.removeFromSuperview()
    }
}
