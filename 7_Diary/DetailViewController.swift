//
//  DetailViewController.swift
//  7_Diary
//
//  Created by 이윤수 on 2021/12/18.
//

import UIKit

class DetailViewController: UIViewController {

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
        return btn
    }()
    
    var titleTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var dateBG : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hue: 0.6, saturation: 0.63, brightness: 0.51, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dataTF : UITextField =  {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var explanation : UIButton = {
        let btn = UIButton()
        btn.setTitle("삭제", for: .normal)
        btn.setTitleColor(UIColor(hue: 0, saturation: 0, brightness: 0.83, alpha: 1.0), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var contentsTV : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor(hue: 0.0778, saturation: 0, brightness: 0.95, alpha: 1.0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
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
        
        self.dateBG.addSubview(self.dataTF)
        NSLayoutConstraint.activate([
            self.dataTF.heightAnchor.constraint(equalTo: self.dateBG.heightAnchor),
            self.dataTF.centerYAnchor.constraint(equalTo: self.dataTF.centerYAnchor),
            self.dataTF.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.dataTF.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10)
        ])
        
        self.view.addSubview(self.contentsTV)
        NSLayoutConstraint.activate([
            self.contentsTV.topAnchor.constraint(equalTo: self.dateBG.bottomAnchor),
            self.contentsTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentsTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.contentsTV.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10)
        ])
        
        self.view.addSubview(self.explanation)
        NSLayoutConstraint.activate([
            self.explanation.topAnchor.constraint(equalTo: self.contentsTV.bottomAnchor, constant: 10),
            self.explanation.leadingAnchor.constraint(equalTo: self.titleBG.leadingAnchor, constant: 10),
            self.explanation.trailingAnchor.constraint(equalTo: self.titleBG.trailingAnchor, constant: -10)
        ])
        
    }
}
