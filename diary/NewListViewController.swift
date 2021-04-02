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
    
    let nameTX = UITextField()
    
    lazy var descriptionTX = UITextField()
    
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
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame.size = contentViewSize
        return view
    }()
    
    let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        setUpNavigation()
        setupEditScreen()
        
        
        nameTX.becomeFirstResponder()
        nameTX.delegate = self
        descriptionTX.delegate = self
        nameTX.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        descriptionTX.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        dateStartPicker.setDate(Date(), animated: true)
        dateFinishPicker.setDate(Date(), animated: true)
        
    }
    func setUp() {
        
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemGray
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentView.addSubview(nameTX)
        contentView.addSubview(descriptionTX)
        contentView.addSubview(dateStartLabel)
        contentView.addSubview(dateFinishLabel)
        contentView.addSubview(dateStartPicker)
        contentView.addSubview(dateFinishPicker)
        
        nameTX.translatesAutoresizingMaskIntoConstraints = false
        nameTX.backgroundColor = .systemBackground
        nameTX.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        nameTX.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        nameTX.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        nameTX.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: nameTX.frame.height))
        nameTX.placeholder = "Событие"
        nameTX.leftViewMode = .always
        nameTX.layer.cornerRadius = 5
        nameTX.layer.borderWidth = 1.0
        nameTX.layer.borderColor = (UIColor(red: 15.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor
        
        descriptionTX.translatesAutoresizingMaskIntoConstraints = false
        descriptionTX.backgroundColor = .systemBackground
        descriptionTX.topAnchor.constraint(equalTo: nameTX.bottomAnchor, constant: 10).isActive = true
        descriptionTX.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        descriptionTX.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        descriptionTX.placeholder = "Описание события"
        descriptionTX.frame.size.height = 100
        descriptionTX.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: nameTX.frame.height))
        descriptionTX.leftViewMode = .always
        descriptionTX.layer.cornerRadius = 5
        descriptionTX.layer.borderWidth = 1.0
        descriptionTX.layer.borderColor = (UIColor(red: 15.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor
        
        dateStartLabel.translatesAutoresizingMaskIntoConstraints = false
        dateStartLabel.backgroundColor = .systemBackground
        dateStartLabel.textAlignment = .center
        dateStartLabel.topAnchor.constraint(equalTo: descriptionTX.bottomAnchor, constant: 10).isActive = true
        dateStartLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        dateStartLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        dateStartPicker.translatesAutoresizingMaskIntoConstraints = false
        dateStartPicker.topAnchor.constraint(equalTo: dateStartLabel.bottomAnchor, constant: 10).isActive = true
        dateStartPicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        dateFinishLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFinishLabel.backgroundColor = .systemBackground
        dateFinishLabel.textAlignment = .center
        dateFinishLabel.topAnchor.constraint(equalTo: dateStartPicker.bottomAnchor, constant: 10).isActive = true
        dateFinishLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        dateFinishLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        dateFinishPicker.translatesAutoresizingMaskIntoConstraints = false
        dateFinishPicker.topAnchor.constraint(equalTo: dateFinishLabel.bottomAnchor, constant: 10).isActive = true
        dateFinishPicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true

        
    }
    func setUpNavigation() {
        
        saveBarButtonItem.isEnabled = false
        
        self.navigationController!.navigationBar.tintColor = UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)
 
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)]
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func textFieldChanged() {
        
        if nameTX.text!.isEmpty == false && descriptionTX.text!.isEmpty == false {
            saveBarButtonItem.isEnabled = true
        } else {
            saveBarButtonItem.isEnabled = false
        }
    }
    private func setupEditScreen() {
        
        if currentList != nil {
            
            nameTX.text = currentList.name
            descriptionTX.text = currentList.descriptionlist
            dateStartPicker.date = currentList.dateStart!
            dateFinishPicker.date = currentList.dateFinish!

        }
    }
    
    
    
    @objc func didTapSaveButton() {
        if dateStartPicker.date < dateFinishPicker.date {
            
            
            let nameText = nameTX.text
            let descriptionText = descriptionTX.text
            let startDate = dateStartPicker.date
            let finishDate = dateFinishPicker.date
            
            let dateStartDay = dateFormatterOffTime.string(from: dateFinish!)
           
            
            var id: String {
                return "\(nameText)-\(descriptionText)-\(String(Self.dateFormatter.string(from: startDate)))-\(String(Self.dateFormatter.string(from: startDate)))"
            }
            
            let newList = List(id: id, dateStart: startDate, dateFinish: finishDate, name: nameText!, descriptionlist: descriptionText!)
            
            if currentList != nil {
                try! realm.write {
                    currentList?.name = newList.name
                    currentList?.descriptionlist = newList.descriptionlist
                    currentList?.dateStart = newList.dateStart
                    currentList?.dateFinish = newList.dateFinish
                }
            } else {
                StorigeManadger.saveObject(newList)
            }
            navigationController?.popToRootViewController(animated: true)
        } else {
            
            let alert = UIAlertController(title: "Введенные данные времени и дат некорректны", message: "Проверте введенные вами параметры даты и времени. Начало событие не может быть позднее его окончания", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel)
            
            alert.addAction(cancel)
            present(alert, animated: true)
            
            dateFinishPicker.backgroundColor = .red
            dateStartPicker.backgroundColor = .red
        }
    }
}
