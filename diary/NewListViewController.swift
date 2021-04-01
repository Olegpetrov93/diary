//
//  NewListViewController.swift
//  diary
//
//  Created by Oleg on 4/1/21.
//

import UIKit

class NewListViewController: UIViewController, UITextFieldDelegate {
    
    var currentList: List!
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    let nameTX : UITextField = {
        let nameTX = UITextField()
        nameTX.placeholder = "Событие"
        nameTX.translatesAutoresizingMaskIntoConstraints = false
        return nameTX
    }()
    let descriptionTX : UITextField = {
        let descriptionTX = UITextField()
        descriptionTX.placeholder = "Описание события"
        descriptionTX.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTX
    }()
    
    let dateStartLabel : UILabel = {
        let dateStartLabel = UILabel()
        dateStartLabel.text = "Начало события"
        dateStartLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateStartLabel
    }()
    
    let dateFinishLabel : UILabel = {
        let dateFinishLabel = UILabel()
        dateFinishLabel.text = "Конец события"
        dateFinishLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateFinishLabel
    }()
    
    let dateStartPicker = UIDatePicker()
    let dateFinishPicker = UIDatePicker()
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        nameTX.becomeFirstResponder()
        nameTX.delegate = self
        
        dateStartPicker.setDate(Date(), animated: true)
        dateFinishPicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    func setUp() {
        
        
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        
        scrollView.addSubview(nameTX)
        scrollView.addSubview(descriptionTX)
        scrollView.addSubview(dateStartLabel)
        scrollView.addSubview(dateFinishLabel)
        scrollView.addSubview(dateStartPicker)
        scrollView.addSubview(dateFinishPicker)
        
        nameTX.anchor(top: scrollView.topAnchor, left: scrollView.leadingAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
        descriptionTX.anchor(top: nameTX.bottomAnchor, left: scrollView.leadingAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 50, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: view.frame.size.height/4, enableInsets: false)
        
        dateStartLabel.anchor(top: descriptionTX.bottomAnchor, left: scrollView.leadingAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width/2 - 20, height: 0, enableInsets: false)
        
        dateStartPicker.anchor(top: dateStartLabel.bottomAnchor, left: scrollView.leadingAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width/2 - 20, height: 0, enableInsets: false)
        
        dateFinishLabel.anchor(top: descriptionTX.bottomAnchor, left: nil, bottom: nil, right: scrollView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: view.frame.size.width/2 - 20, height: 0, enableInsets: false)
        
        dateFinishPicker.anchor(top: dateFinishLabel.bottomAnchor, left: nil, bottom: nil, right: scrollView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: view.frame.size.width/2 - 20, height: 0, enableInsets: false)
        
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func didTapSaveButton() {
        if let nameText = nameTX.text, !nameText.isEmpty, let descriptionText = descriptionTX.text, !descriptionText.isEmpty {
            
            let startDate = dateStartPicker.date
            let finishDate = dateFinishPicker.date
            
            var id: String {
                return "\(nameText)-\(descriptionText)-\(String(Self.dateFormatter.string(from: startDate)))-\(String(Self.dateFormatter.string(from: startDate)))"
            }
            
            let newList = List(id: id, dateStart: startDate, dateFinish: finishDate, name: nameText, descriptionlist: descriptionText)
            
            StorigeManadger.saveObject(newList)
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
