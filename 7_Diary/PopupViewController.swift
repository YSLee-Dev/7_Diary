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
            self.popupView.heightAnchor.constraint(equalToConstant: 350),
            self.popupView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.addSubview(self.datePicker)
        NSLayoutConstraint.activate([
            self.datePicker.centerXAnchor.constraint(equalTo: self.popupView.centerXAnchor),
            self.datePicker.centerYAnchor.constraint(equalTo: self.popupView.centerYAnchor),
            self.datePicker.heightAnchor.constraint(equalTo: self.popupView.heightAnchor, multiplier: 0.65),
            self.datePicker.widthAnchor.constraint(equalTo: self.popupView.widthAnchor, multiplier: 0.9)
        ])
        
        self.view.addSubview(self.popupTitle)
        NSLayoutConstraint.activate([
            self.popupTitle.bottomAnchor.constraint(equalTo: self.datePicker.topAnchor, constant: -10),
            self.popupTitle.centerXAnchor.constraint(equalTo: self.popupView.centerXAnchor)
        ])
        
        self.view.addSubview(self.closeBtn)
        NSLayoutConstraint.activate([
            self.closeBtn.centerYAnchor.constraint(equalTo: self.popupTitle.centerYAnchor),
            self.closeBtn.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor, constant: -15)
        ])
        
        self.view.addSubview(self.okBtn)
        NSLayoutConstraint.activate([
            self.okBtn.centerXAnchor.constraint(equalTo: self.popupView.centerXAnchor),
            self.okBtn.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 5),
            self.okBtn.widthAnchor.constraint(equalTo: self.datePicker.widthAnchor),
            self.okBtn.heightAnchor.constraint(equalToConstant: 50)
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
