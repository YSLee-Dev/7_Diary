//
//  PopupViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2022/01/04.
//

import UIKit

protocol Datasend : AnyObject {
    func data(date:Date)
    func close()
}

class PopupViewController : UIViewController{
 
    var popupView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var popupTitle : UILabel = {
        let title = UILabel()
        title.text = "날짜를 선택해주세요."
        title.font  = UIFont.boldSystemFont(ofSize: 19)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var closeBtn : UIButton = {
        let btn = UIButton(type: .close)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(closeClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var okBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("저장", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hue: 0.6083, saturation: 0.72, brightness: 0.35, alpha: 1.0)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(saveClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    var datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        dp.maximumDate = Date()
        dp.locale = Locale(identifier: "ko-KR")
        dp.addTarget(self, action: #selector(dateC(_:)), for: .valueChanged)
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    weak var delegate : Datasend?
    var date = Date()
    
    override func viewDidLoad() {
        viewSet()
    }
    
    private func viewSet(){
        self.view.backgroundColor = .clear
        
        self.view.addSubview(self.popupView)
        NSLayoutConstraint.activate([
            self.popupView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.popupView.heightAnchor.constraint(equalToConstant: 400),
            self.popupView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 15)
        ])
        
        self.view.addSubview(self.popupTitle)
        NSLayoutConstraint.activate([
            self.popupTitle.topAnchor.constraint(equalTo: self.popupView.topAnchor, constant: 20),
            self.popupTitle.centerXAnchor.constraint(equalTo: self.popupView.centerXAnchor)
        ])
        
        self.view.addSubview(self.closeBtn)
        NSLayoutConstraint.activate([
            self.closeBtn.centerYAnchor.constraint(equalTo: self.popupTitle.centerYAnchor),
            self.closeBtn.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor, constant: -15)
        ])
        
        self.view.addSubview(self.closeBtn)
        NSLayoutConstraint.activate([
            self.closeBtn.centerYAnchor.constraint(equalTo: self.popupTitle.centerYAnchor),
            self.closeBtn.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor, constant: -15)
        ])
        
        self.view.addSubview(self.okBtn)
        NSLayoutConstraint.activate([
            self.okBtn.leadingAnchor.constraint(equalTo: self.popupView.leadingAnchor, constant: 15),
            self.okBtn.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor, constant: -15),
            self.okBtn.heightAnchor.constraint(equalToConstant: 50),
            self.okBtn.bottomAnchor.constraint(equalTo: self.popupView.bottomAnchor, constant: -45)
        ])
        
        self.view.addSubview(self.datePicker)
        NSLayoutConstraint.activate([
            self.datePicker.leadingAnchor.constraint(equalTo: self.popupView.leadingAnchor, constant: 15),
            self.datePicker.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor, constant: -15),
            self.datePicker.topAnchor.constraint(equalTo: self.popupTitle.bottomAnchor, constant: 15),
            self.datePicker.bottomAnchor.constraint(equalTo: self.okBtn.topAnchor, constant: -15)
            
        ])
        
        
        
    }
    
    
    
    @objc func saveClick(_ sender:Any){
        self.delegate?.data(date: self.date)
        self.dismiss(animated: true)
    }
    
    @objc func closeClick(_ sender:Any){
        self.delegate?.close()
        self.dismiss(animated: true)
    }
    
    @objc func dateC(_ sender:UIDatePicker){
        self.date = sender.date
    }
}
