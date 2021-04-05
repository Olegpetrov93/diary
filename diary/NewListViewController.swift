//
//  NewListViewController.swift
//  diary
//
//  Created by Oleg on 4/1/21.
//

import UIKit

final class NewListViewController: UIViewController {
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    var currentList: List!
    
    private let nameTX = UITextField()
    
    private lazy var descriptionTX = UITextField()
    
    private let dateStartLabel : UILabel = {
        let dateStartLabel = UILabel()
        dateStartLabel.text = "Начало события"
        dateStartLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateStartLabel
    }()
    
    private let dateFinishLabel : UILabel = {
        let dateFinishLabel = UILabel()
        dateFinishLabel.text = "Конец события"
        dateFinishLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateFinishLabel
    }()
    
    private let dateStartPicker : UIDatePicker = {
        let dateStartPicker = UIDatePicker()
        dateStartPicker.locale = Locale(identifier: "ru_RU")
        return dateStartPicker
    }()
    private let dateFinishPicker : UIDatePicker = {
        let dateFinishPicker = UIDatePicker()
        dateFinishPicker.locale = Locale(identifier: "ru_RU")
        return dateFinishPicker
    }()
    
    private let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    
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
        
        //        let startDate = Date().addingTimeInterval(1 * 60 * 60)
        //        dateStartPicker.setDate(startDate, animated: true)
        //        dateStartPicker.maximumDate = startDate.addingTimeInterval(1 * 60 * 60)
        //        dateFinishPicker.setDate(dateStartPicker.maximumDate!, animated: true)
        //        dateFinishPicker.minimumDate = dateStartPicker.maximumDate!
        // не успел доработать логику
        
        dateStartPicker.addTarget(self, action: #selector(pickerChange(_:)), for: .valueChanged)
        
    }
    
    @objc func pickerChange(_ picker: UIDatePicker) {
        if picker == dateStartPicker {
            dateFinishPicker.minimumDate = dateStartPicker.date.addingTimeInterval(1 * 60 * 60)
        }
        
        if picker == dateFinishPicker {
            dateStartPicker.maximumDate = dateFinishPicker.date.addingTimeInterval(-1 * 60 * 60)
        }
    }
    
    // MARK: - Setups
    
    func setUp() {
        
        view.backgroundColor = .white
        
        view.addSubview(nameTX)
        view.addSubview(descriptionTX)
        view.addSubview(dateStartLabel)
        view.addSubview(dateFinishLabel)
        view.addSubview(dateStartPicker)
        view.addSubview(dateFinishPicker)
        
        nameTX.translatesAutoresizingMaskIntoConstraints = false
        nameTX.backgroundColor = .white
        nameTX.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        nameTX.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        nameTX.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        nameTX.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: nameTX.frame.height))
        nameTX.placeholder = "Событие"
        nameTX.leftViewMode = .always
        nameTX.layer.cornerRadius = 5
        nameTX.layer.borderWidth = 1.0
        nameTX.layer.borderColor = (UIColor(red: 15.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor
        
        descriptionTX.translatesAutoresizingMaskIntoConstraints = false
        descriptionTX.backgroundColor = .white
        descriptionTX.topAnchor.constraint(equalTo: nameTX.bottomAnchor, constant: 10).isActive = true
        descriptionTX.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        descriptionTX.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        descriptionTX.placeholder = "Описание события"
        descriptionTX.heightAnchor.constraint(equalToConstant: 50).isActive = true
        descriptionTX.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: nameTX.frame.height))
        descriptionTX.leftViewMode = .always
        descriptionTX.layer.cornerRadius = 5
        descriptionTX.layer.borderWidth = 1.0
        descriptionTX.layer.borderColor = (UIColor(red: 15.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor
        
        dateStartLabel.translatesAutoresizingMaskIntoConstraints = false
        dateStartLabel.backgroundColor = .white
        dateStartLabel.textAlignment = .center
        dateStartLabel.topAnchor.constraint(equalTo: descriptionTX.bottomAnchor, constant: 10).isActive = true
        dateStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        dateStartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        dateStartPicker.translatesAutoresizingMaskIntoConstraints = false
        dateStartPicker.topAnchor.constraint(equalTo: dateStartLabel.bottomAnchor, constant: 10).isActive = true
        dateStartPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        dateFinishLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFinishLabel.backgroundColor = .white
        dateFinishLabel.textAlignment = .center
        dateFinishLabel.topAnchor.constraint(equalTo: dateStartPicker.bottomAnchor, constant: 10).isActive = true
        dateFinishLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        dateFinishLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        dateFinishPicker.translatesAutoresizingMaskIntoConstraints = false
        dateFinishPicker.topAnchor.constraint(equalTo: dateFinishLabel.bottomAnchor, constant: 10).isActive = true
        dateFinishPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setUpNavigation() {
        saveBarButtonItem.isEnabled = false
        
        self.navigationController!.navigationBar.tintColor = UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)
        
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor(red: 180/255,
                                                           green: 215/255,
                                                           blue: 241/255,
                                                           alpha: 1)
        ]
    }
    
    private func setupEditScreen() {
        if currentList != nil {
            nameTX.text = currentList.name
            descriptionTX.text = currentList.descriptionList
            dateStartPicker.date = currentList.dateStart!
            dateFinishPicker.date = currentList.dateFinish!
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapSaveButton() {
        if dateStartPicker.date < dateFinishPicker.date {
            let nameText = nameTX.text
            let descriptionText = descriptionTX.text
            let startDate = timeAdjustment(date: dateStartPicker.date)
            let finishDate = timeAdjustment(date: dateFinishPicker.date)
            
            let newList = List(id: UUID().uuidString, name: nameText!, descriptionlist: descriptionText!, dateStart: startDate, dateFinish: finishDate)
            
            if currentList != nil {
                try! realm.write {
                    currentList?.name = newList.name
                    currentList?.descriptionList = newList.descriptionList
                    currentList?.dateStart = newList.dateStart
                    currentList.dateStartDay = newList.dateStartDay
                    currentList?.dateFinish = newList.dateFinish
                    currentList.dateFinishDay = newList.dateFinishDay
                }
            } else {
                StorageManager.saveObject(newList)
            }
            
            navigationController?.popToRootViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Введенные данные времени и дат некорректны",
                                          message: "Проверьте введенные вами параметры даты и времени. Начало событие не может быть позднее его окончания",
                                          preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel)
            
            alert.addAction(cancel)
            present(alert, animated: true)
            
            dateFinishPicker.backgroundColor = .red
            dateStartPicker.backgroundColor = .red
        }
    }
    func timeAdjustment(date: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = Calendar.current.component(.day, from: date)
        dateComponents.month = Calendar.current.component(.month, from: date)
        dateComponents.year = Calendar.current.component(.year, from: date)
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        if Calendar.current.component(.hour, from: date) < 15 {
            dateComponents.minute = 0
        } else if Calendar.current.component(.hour, from: date) >= 15 && Calendar.current.component(.hour, from: date) < 30 {
            dateComponents.minute = 15
        } else if Calendar.current.component(.hour, from: date) >= 30 && Calendar.current.component(.hour, from: date) < 45 {
            dateComponents.minute = 30
        } else {
            dateComponents.minute = 45
        }
        guard let dataConvert = Calendar.current.date(from: dateComponents) else { return date }
        return dataConvert
    }
}


extension NewListViewController: UITextFieldDelegate {
    
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
}
