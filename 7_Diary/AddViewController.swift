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
    
    var okBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("확인", for: .normal)
        btn.setTitleColor(UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0), for: .disabled)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(saveBtnClick(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        let ti = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(closeKey(_:)))
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
    
    
    weak var delegate:AddDiaryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "일기작성"
        
        viewSetup()
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
        
        self.addStackView.addArrangedSubview(self.contentsBG)
        NSLayoutConstraint.activate([
            self.contentsBG.heightAnchor.constraint(equalToConstant: 125)
        ])
        
        self.contentsBG.addSubview(self.contentsTV)
        self.contentsTV.inputAccessoryView = self.toolBar
        NSLayoutConstraint.activate([
            self.contentsTV.bottomAnchor.constraint(equalTo: self.contentsBG.bottomAnchor),
            self.contentsTV.heightAnchor.constraint(equalTo: self.contentsBG.heightAnchor),
            self.contentsTV.leadingAnchor.constraint(equalTo: self.contentsBG.leadingAnchor, constant: 5),
            self.contentsTV.trailingAnchor.constraint(equalTo: self.contentsBG.trailingAnchor, constant: -5),
        ])
        
        self.okBtn.isEnabled = false
        self.addStackView.addArrangedSubview(self.okBtn)
        NSLayoutConstraint.activate([
        ])
    }
    
    
    // 텍스트 입력 여부 확인
    private func inputCheck(){
        self.contentsTV.delegate = self
        self.titleTF.addTarget(self, action: #selector(textFiledCheck(_:)), for: .editingChanged)
    }
    
    @objc func textFiledCheck(_ textField : UITextField){
        self.inputFieldCheck()
    }
    
    
    // 텍스트 입력 여부 확인
    private func inputFieldCheck(){
        self.okBtn.isEnabled = !(self.titleTF.text?.isEmpty ?? true) && !self.contentsTV.text.isEmpty
    }
    
    // 저장버튼 클릭
    @objc func saveBtnClick(_ sender:Any){
        bgViewUp()
        self.view.endEditing(true)
        let popup = PopupViewController()
        popup.modalPresentationStyle = .overFullScreen
        popup.delegate = self
        self.present(popup, animated: true)
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

extension AddViewController : Datasend{
    func data(date: Date) {
        
        self.bgView.removeFromSuperview()
        
        guard let title = self.titleTF.text else {return}
        guard let contents = self.contentsTV.text else {return}
        
        let diary = Diary(title: title, contents: contents, date: date, star: false)
        self.delegate?.valueRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
    func close() {
        self.bgView.removeFromSuperview()
    }
}
