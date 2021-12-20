//
//  AddViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/11.
//

import UIKit

protocol AddDiaryDelegate:AnyObject {
    func valueRegister(diary:Diary)
}

class AddViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var titleBG : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hue: 0.6083, saturation: 0.72, brightness: 0.35, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var backBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("< 일기장으로", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(BackBtnClick), for: .touchUpInside)
        return btn
    }()
    
    var titleTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.attributedPlaceholder = NSAttributedString(string: "제목을 입력하세요.",attributes: [NSAttributedString.Key.foregroundColor :  UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0)])
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var dateBG : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hue: 0.6, saturation: 0.63, brightness: 0.51, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dateTF : UITextField =  {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.attributedPlaceholder = NSAttributedString(string: "날짜를 선택하세요.",attributes: [NSAttributedString.Key.foregroundColor :  UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0)])
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var okBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("저장", for: .normal)
        btn.setTitleColor(UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0), for: .disabled)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(saveBtnClick(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var contentsTV : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor(hue: 0.0778, saturation: 0, brightness: 0.95, alpha: 1.0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let datePicker = UIDatePicker()
    private var dateS:Date?
    weak var delegate:AddDiaryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // 네비게이션 숨김 및 제스처 동작 가능 구문
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
        viewSetup()
        datePickerFunc()
        inputCheck()
        
    }
    
    private func viewSetup(){
        self.view.addSubview(self.titleBG)
        NSLayoutConstraint.activate([
            self.titleBG.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.titleBG.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            self.titleBG.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.titleBG.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.titleBG.addSubview(self.titleTF)
        NSLayoutConstraint.activate([
            self.titleTF.bottomAnchor.constraint(equalTo: self.titleBG.bottomAnchor, constant: -10),
            self.titleTF.heightAnchor.constraint(equalTo: self.titleBG.heightAnchor, multiplier: 0.3),
            self.titleTF.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.titleTF.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10)
        ])
        
        self.titleBG.addSubview(self.backBtn)
        NSLayoutConstraint.activate([
            self.backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.backBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        
        self.view.addSubview(self.dateBG)
        NSLayoutConstraint.activate([
            self.dateBG.topAnchor.constraint(equalTo: self.titleBG.bottomAnchor),
            self.dateBG.heightAnchor.constraint(equalTo: self.titleTF.heightAnchor, constant: 15),
            self.dateBG.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.dateBG.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.dateBG.addSubview(self.dateTF)
        NSLayoutConstraint.activate([
            self.dateTF.heightAnchor.constraint(equalTo: self.dateBG.heightAnchor),
            self.dateTF.centerYAnchor.constraint(equalTo: self.dateTF.centerYAnchor),
            self.dateTF.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.dateTF.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10)
        ])
        
        self.view.addSubview(self.contentsTV)
        NSLayoutConstraint.activate([
            self.contentsTV.topAnchor.constraint(equalTo: self.dateBG.bottomAnchor),
            self.contentsTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentsTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentsTV.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10)
        ])
        
        self.okBtn.isEnabled = false
        self.view.addSubview(self.okBtn)
        NSLayoutConstraint.activate([
            self.okBtn.topAnchor.constraint(equalTo: self.contentsTV.bottomAnchor, constant: 10),
            self.okBtn.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.okBtn.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10)
        ])
    }
    
    private func datePickerFunc(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValue(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR")
        self.dateTF.inputView = self.datePicker
    }
    
    @objc func datePickerValue(_ dataPicker:UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy.MM.dd(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.dateS = self.datePicker.date
        self.dateTF.text = formmater.string(from: self.datePicker.date)
        self.dateTF.sendActions(for: .editingChanged)
    }
    
    // 텍스트 입력 여부 확인
    private func inputCheck(){
        self.contentsTV.delegate = self
        self.titleTF.addTarget(self, action: #selector(textFiledCheck(_:)), for: .editingChanged)
        self.dateTF.addTarget(self, action: #selector(textFiledCheck(_:)), for: .editingChanged)
    }
    
    @objc func textFiledCheck(_ textField : UITextField){
        self.inputFieldCheck()
    }
    
    // 백버튼 클릭
    @objc func BackBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 입력 여부 확인
    private func inputFieldCheck(){
        self.okBtn.isEnabled = !(self.titleTF.text?.isEmpty ?? true) && !(self.dateTF.text?.isEmpty ?? true) && !self.contentsTV.text.isEmpty
    }
    
    // 저장버튼 클릭
    @objc func saveBtnClick(_ sender:Any){
        guard let title = self.titleTF.text else {return}
        guard let contents = self.contentsTV.text else {return}
        guard let date = self.dateS else {return}
        let diary = Diary(title: title, contents: contents, date: date, star: false)
        self.delegate?.valueRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.inputFieldCheck()
    }
}
