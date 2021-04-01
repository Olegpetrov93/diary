//
//  ViewController.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit
import RealmSwift

class RootVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var toDoList : Results<List>!
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        toDoList = realm.objects(List.self)
        
        setUpNavigation()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(CastomCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(CalendarCell.self, forCellReuseIdentifier: "CalendarCell")
        
        //        editButtonItem.action =  #selector(openNewVC)
        
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CastomCell
            
            let list = toDoList[indexPath.row-1]
            
            cell.nameLabel.text = list.name
            cell.dateStartLabel.text = "Начало \(Self.dateFormatter.string(from: list.dateStart!))"
            cell.dateFinishLabel.text = "Конец \(Self.dateFormatter.string(from: list.dateFinish!))"
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return view.frame.size.height/2
        } else {
            return 80
        }
    }
    
    func setUpNavigation() {
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNewVC))
        
        saveBarButtonItem.tintColor = UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        navigationItem.title = "Список дел"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 112/255, blue: 182/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)]
    }
        @objc func openNewVC() {
    
            let vc = NewListViewController()
            vc.modalPresentationStyle = .fullScreen
    
            present(vc, animated: true, completion: nil)
        }
    @objc func printHello() {
        print("Hello")
    }

}

