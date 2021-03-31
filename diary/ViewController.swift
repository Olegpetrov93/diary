//
//  ViewController.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit

class RootVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var toDoList = List.getList()
    
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
        
        setUpNavigation()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(CastomCell.self, forCellReuseIdentifier: "Cell")
        
//        editButtonItem.action =  #selector(openNewVC)
        
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CastomCell
        
        if 
        
        
        let list = toDoList[indexPath.row]
        
        cell.nameLabel.text = list.name
        cell.dateStartLabel.text = Self.dateFormatter.string(from: list.dateStart!)
        cell.dateFinishLabel.text = Self.dateFormatter.string(from: list.dateFinish!)

        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    func setUpNavigation() {

        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(printHello))
        
        saveBarButtonItem.tintColor = UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)
            self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
     navigationItem.title = "Список дел"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 112/255, blue: 182/255, alpha: 1)
     self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)]
    }
//    @objc func openNewVC() {
//
//        let vc = NewField()
//        vc.modalPresentationStyle = .fullScreen
//        vc.delegate = self
//
//        present(vc, animated: true, completion: nil)
//    }
//}
    @objc func printHello() {
        print("Hello")
    }
//extension RootVC : FermerManagerDataSource {
//    func addField(field: Field) {
//        fermer.fields?.append(field)
//        tableView.reloadData()
//    }
}

