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
        view.layer.cornerRadius = 15
        return view
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
        view.layer.cornerRadius = 15
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
        tv.layer.cornerRadius = 15
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
        let ti = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(closeKey(_:)))
        tb.sizeToFit()
        tb.setItems([ti], animated: true)
        return tb
    }()
    
    private let datePicker = UIDatePicker()
    private var dateS:Date?
    weak var delegate:AddDiaryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "일기작성"
        
        viewSetup()
        datePickerFunc()
        inputCheck()
        
    }
    
    private func viewSetup(){
        
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
        
        self.addStackView.addArrangedSubview(self.dateBG)
        NSLayoutConstraint.activate([
            self.dateBG.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.dateBG.addSubview(self.dateTF)
        self.dateTF.inputAccessoryView = self.toolBar
        NSLayoutConstraint.activate([
            self.dateTF.heightAnchor.constraint(equalTo: self.dateBG.heightAnchor),
            self.dateTF.centerYAnchor.constraint(equalTo: self.dateTF.centerYAnchor),
            self.dateTF.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.dateTF.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10)
        ])
        
        self.addStackView.addArrangedSubview(self.contentsTV)
        self.contentsTV.inputAccessoryView = self.toolBar
        NSLayoutConstraint.activate([
            self.contentsTV.heightAnchor.constraint(equalToConstant: 125)
        ])
        
        self.okBtn.isEnabled = false
        self.addStackView.addArrangedSubview(self.okBtn)
        NSLayoutConstraint.activate([
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
    
    // 키보드 내리기
    @objc func closeKey(_ sender:Any){
        self.view.endEditing(true)
    }
    
}

extension AddViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.inputFieldCheck()
    }
}
