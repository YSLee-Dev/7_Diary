//
//  AddViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/11.
//

import UIKit

protocol AddDiaryDelegate:AnyObject {
    func valueRegister(diary:Diary)
    func deleteDiary(PIndexPath : IndexPath)
    func starSelect(PIndexPath : IndexPath, star : Bool)
}

enum Mode{
    case add
    case edit(IndexPath, Diary)
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
        tf.layer.cornerRadius = 15
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.smartQuotesType = .no
        tf.smartDashesType = .no
        tf.smartInsertDeleteType = .no
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
        tv.backgroundColor = UIColor(hue: 0.0778, saturation: 0, brightness: 0.95, alpha: 1.0)
        return tv
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
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var blankView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    weak var delegate:AddDiaryDelegate?
    var viewMode:Mode = .add
    var keyHeight : CGFloat?
    
    var editBtn : UIBarButtonItem?
    var deleteBtn : UIBarButtonItem?
    var editOkBtn : UIBarButtonItem?
    var starBtn : UIBarButtonItem?
    var detailIndexPath:IndexPath?
    var isStar:Bool = false
    
    
    override func viewDidLoad() {
        
        viewSetup()
        inputCheck()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    private func loadEdit(Diary : Diary){
        self.view.backgroundColor = .white
        
        self.titleTF.text = Diary.title
        self.contentsTV.text = Diary.contents
        self.title = dateToString(date: Diary.date)
        self.isStar = Diary.star
        
        self.titleTF.isEnabled = false
        self.contentsTV.isEditable = false
        
        
        self.editBtn = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(editBtnClick(_:)))
        self.deleteBtn = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteBtnClick(_:)))
        self.editOkBtn = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveBtnClick(_:)))
        self.starBtn = UIBarButtonItem(image: nil, style: .done, target: self, action: #selector(starBtnClick(_:)))
        
        self.navigationItem.setRightBarButtonItems([self.editBtn!,self.deleteBtn!,self.starBtn!], animated: true)
        self.navigationItem.rightBarButtonItems![1].tintColor = .red
        self.starBtn?.image = Diary.star ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    private func loadAdd(){
        self.view.backgroundColor = .white
        self.title = "일기작성"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"", style: .done, target: self, action: #selector(saveBtnClick(_:)))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func viewSetup(){
        
        switch self.viewMode {
        case let .edit(index, Diary):
            self.detailIndexPath = index
            loadEdit(Diary: Diary)
            break
        default:
            loadAdd()
            break
            
        }
        
        let margin = (self.navigationController?.systemMinimumLayoutMargins.leading)
        
        self.view.addSubview(self.titleBG)
        NSLayoutConstraint.activate([
            self.titleBG.heightAnchor.constraint(equalToConstant: 50),
            self.titleBG.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.titleBG.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin!),
            self.titleBG.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin!),
        ])
        
        self.titleBG.addSubview(self.titleTF)
        self.titleTF.inputAccessoryView = self.toolBar
        NSLayoutConstraint.activate([
            self.titleTF.bottomAnchor.constraint(equalTo: self.titleBG.bottomAnchor),
            self.titleTF.heightAnchor.constraint(equalTo: self.titleBG.heightAnchor),
            self.titleTF.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.titleTF.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10),
        ])
        
        self.view.addSubview(self.contentsBG)
        NSLayoutConstraint.activate([
            self.contentsBG.topAnchor.constraint(equalTo: self.titleBG.bottomAnchor, constant: 10),
            self.contentsBG.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.contentsBG.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin!),
            self.contentsBG.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin!),
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
    
    deinit{
        NotificationCenter.default.removeObserver(self)
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
        self.navigationItem.rightBarButtonItem?.isEnabled = !(self.titleTF.text?.isEmpty ?? true) && !self.contentsTV.text.isEmpty
    }
    
    // 저장버튼 클릭
    @objc func saveBtnClick(_ sender:Any){
        bgViewUp()
        self.view.endEditing(true)
        let popup = PopupViewController()
        popup.modalPresentationStyle = .overFullScreen
        popup.delegate = self
        popup.viewMode = self.viewMode
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
        
        DispatchQueue.main.async { [weak self] in
            self?.bgView.alpha = 0.3
        }
    }
    
    
    // 삭제버튼 클릭 시
    @objc func deleteBtnClick(_ sender:Any){
        guard let index = self.detailIndexPath else {return}
        self.delegate?.deleteDiary(PIndexPath: index)
        self.navigationController?.popViewController(animated: true)
    }
    
    // 수정버튼 클릭 시
    @objc func editBtnClick(_ sender:Any){
        self.titleTF.isEnabled = true
        self.contentsTV.isEditable = true
        
        self.navigationItem.rightBarButtonItems![0] = self.editOkBtn!
        self.navigationItem.rightBarButtonItems![1].isEnabled = false
        self.navigationItem.rightBarButtonItems![2].isEnabled = false
    }
    
    // 즐겨찾기버튼 클릭 시
    @objc func starBtnClick(_ sender:Any){
        if self.isStar{
            self.starBtn?.image = UIImage(systemName: "star")
        }else{
            self.starBtn?.image = UIImage(systemName: "star.fill")
        }
        self.isStar = !isStar
        self.delegate?.starSelect(PIndexPath: self.detailIndexPath!, star: self.isStar)
    }
    
    // 날짜 데이터 변환
    func dateToString(date : Date) -> String{
        let Formatter = DateFormatter()
        Formatter.dateFormat = "YY.MM.dd | EEE"
        Formatter.locale = Locale(identifier: "ko-KR")
        
        return Formatter.string(from: date)
    }
    
    // 키보드 내리기
    @objc func closeKey(_ sender:Any){
        self.view.endEditing(true)
    }
    
    // 작성 필요
    @objc func keyboardShow(_ sender: Notification) {
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.keyHeight = keyboardHeight

    }
    
    // 작성 필요
    @objc func keyboardHide(_ sender: Notification) {
        
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
    
    func edit(date: Date) {
        self.bgView.removeFromSuperview()
        
        self.navigationItem.title = dateToString(date: date)
        
        self.titleTF.isEnabled = true
        self.contentsTV.isEditable = true
        
        self.navigationItem.rightBarButtonItems![0] = self.editBtn!
        self.navigationItem.rightBarButtonItems![1].isEnabled = true
        self.navigationItem.rightBarButtonItems![2].isEnabled = true
        
        let diary = Diary(title: self.titleTF.text!, contents: self.contentsTV.text, date: date, star: false)
        
        NotificationCenter.default.post(name: NSNotification.Name("edit"), object: diary, userInfo: ["row":self.detailIndexPath!.row])
    }
}
