//
//  ViewController.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit
import RealmSwift
import FSCalendar

class RootVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var toDoList : Results<List>!
    
    
    let calendar = FSCalendar()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    let tableView = UITableView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        toDoList = realm.objects(List.self)
        
        setUpCalendar()
        setUpNavigation()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CastomCell.self, forCellReuseIdentifier: "Cell")
        //        tableView.register(CalendarCell.self, forCellReuseIdentifier: "CalendarCell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        if indexPath.row == 0 {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        //
        //            return cell
        //        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CastomCell
        
        let list = toDoList[indexPath.row]
        
        cell.nameLabel.text = list.name
        cell.dateStartLabel.text = "Начало \(Self.dateFormatter.string(from: list.dateStart!))"
        cell.dateFinishLabel.text = "Конец \(Self.dateFormatter.string(from: list.dateFinish!))"
        return cell
    }
    
    //}
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let list = toDoList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delite") {  (contextualAction, view, boolValue) in
            
            StorigeManadger.deliteObject(list)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if indexPath.row == 0 {
//            return view.frame.size.height/2
//        } else {
            return 80
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let list = toDoList[indexPath.row]
        
        let vc = NewListViewController()
        
        vc.currentList = list
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = list.name
        navigationController?.pushViewController(vc, animated: true)
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
    
    func setUpCalendar() {
        
        view.addSubview(tableView)
        view.addSubview(calendar)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        
        calendar.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: calendar.frame.size.height).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    @objc func openNewVC() {
        
        let vc = NewListViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.title = "Новоле событие"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func printHello() {
        print("Hello")
    }
    
}

