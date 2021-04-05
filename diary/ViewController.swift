//
//  ViewController.swift
//  diary
//
//  Created by Oleg on 3/30/21.
//

import UIKit
import RealmSwift
import FSCalendar
import MobileCoreServices

final class RootVC: UIViewController {
    
    private lazy var contentViewRect = CGRect(x: indent,
                                              y: 0,
                                              width: self.view.frame.width - indent,
                                              height: self.view.frame.height + 200)

    private lazy var canvasViewRect = CGRect(x: 0,
                                             y: 0,
                                             width: indent,
                                             height: self.view.frame.height + 200)
    private lazy var scrolViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = scrolViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: contentViewRect)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var canvasView: UIView = {
        let view = UIView(frame: canvasViewRect)
        view.backgroundColor = .clear
        return view
    }()
    
    private var events : [Event] = []
    private let calendar = FSCalendar()
    
    private let indent: CGFloat = 60
    
    private var toDoList : Results<List>?
    private var filtredList : Results<List>?
    
    private var todayStart = Calendar.current.startOfDay(for: Date())
    private var todayStartString: String {
        get {
            dateFormatterOffTime.string(from: todayStart)
        }
    }
    
    // MARK: - VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoList = realm.objects(List.self)
        
        calendar.delegate = self
        
        setUpCalendar()
        setUpNavigation()
        setupDaily()
        
        filterContentForSearchDate()
        reloadEvents()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        reloadData()
    }
    
    // MARK: - Setups
    
    private func setUpNavigation() {
        let importExportItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                               target: self,
                                               action: #selector(importExportAction))
        
        importExportItem.tintColor = UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)
        self.navigationItem.leftBarButtonItem = importExportItem
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                target: self,
                                                action: #selector(openNewVC))
        
        saveBarButtonItem.tintColor = UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        
        navigationItem.title = "Список дел"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 112/255, blue: 182/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 180/255, green: 215/255, blue: 241/255, alpha: 1)]
    }
    
    private func setUpCalendar() {
        view.addSubview(calendar)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: view.frame.size.height/3).isActive = true
        calendar.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(canvasView)
        scrollView.addSubview(contentView)
    }
    
    private func setupDaily() {
        let hourHeight = (canvasView.frame.size.height-40) / 24
        for i in 0...24 {
            let devider = UIView(frame: CGRect(x: 0,
                                               y: hourHeight * CGFloat(i),
                                               width: scrollView.frame.width,
                                               height: 0.5))
            devider.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            
            let label = UILabel(frame: CGRect(x: 0,
                                              y: 0,
                                              width: indent,
                                              height: hourHeight))
            label.text = "  \(i):00"
            label.center.y = devider.frame.origin.y + label.frame.height / 2
            label.textAlignment = .center
            
            scrollView.addSubview(devider)
            canvasView.addSubview(label)
        }
    }
    
    // MARK: - Reload Data
    
    private func reloadData() {
        filterContentForSearchDate()
        reloadEvents()
    }
    
    private func filterContentForSearchDate() {
        let sortProperties = [
            SortDescriptor(keyPath: "dateStart", ascending: true),
            SortDescriptor(keyPath: "dateFinish", ascending: false)
        ]
        filtredList = toDoList!.filter("dateStartDay CONTAINS[c] %@ OR dateFinishDay CONTAINS[c] %@", todayStartString, todayStartString).sorted(by: sortProperties)
        
        events = Event.createEvent(filtredList: filtredList, day: todayStart)!
    }
    
    private func reloadEvents() {
        self.contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        if events.count != 0 {
            for i in 0...events.count - 1 {
                
                
                let rect = CGRect(x: (CGFloat(events[i].x0) * contentView.frame.size.width) ,
                                  y: ((contentView.frame.size.height - 40) * CGFloat(events[i].y0) / 24) + 3,
                                  width: (contentView.frame.size.width-10) * CGFloat(events[i].x1 - events[i].x0),
                                  height: (contentView.frame.size.height - 40) * CGFloat((events[i].y1 - events[i].y0) / 24) - 5)
                
                let itemView = EventView(frame: rect)
                itemView.layer.cornerRadius = 5
                itemView.layer.borderWidth = 1.0
                itemView.layer.borderColor = (UIColor(red: 15.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor
                itemView.isOpaque = false
                itemView.backgroundColor = .random()
                
                itemView.title = events[i].list.name
                itemView.onTap = { [weak self] in
                    guard let self = self else { return }
                    let vc = NewListViewController()
                    
                    vc.currentList = self.events[i].list
                    
                    vc.navigationItem.largeTitleDisplayMode = .never
                    vc.title = vc.currentList.name
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                self.contentView.addSubview(itemView)
            }
        }
    }
    
    // MARK: - Helpers
    
    @objc private func openNewVC() {
        let vc = NewListViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.title = "Новое событие"
        
        //                    let storyboard = UIStoryboard(name: "NewListVC", bundle: nil)
        //                    let vc = storyboard.instantiateViewController(withIdentifier: "NewListVC") as! NewListVC
        // создал storyboard с установленными view, так как настройку в коде сделал раньше оставил рабочую версию в коде. Но если потребуется дополнительно, что-то показать то я готов
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func importExportAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Import", style: .default, handler: { [weak self] _ in
            self?.importAction()
        }))
        
        alert.addAction(UIAlertAction(title: "Export", style: .default, handler: { [weak self] _ in
            self?.exportAction()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}

// MARK: - FSCalendarDelegate
extension RootVC: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        todayStart = date
        reloadData()
    }
}

// MARK: - Import Export
extension RootVC: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            do {
                let data = try Data(contentsOf: url)
                DataService.importFrom(json: data)
                reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func importAction() {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypeItem),
                                                                                      String(kUTTypeText)], in: .import)
        documentPickerController.allowsMultipleSelection = false
        documentPickerController.delegate = self
        present(documentPickerController, animated: true, completion: nil)
    }
    
    private func exportAction() {
        let exportArr = DataService.exportRealmData()
        let jsonString = exportArr?.jsonString
        
        let activityViewController = UIActivityViewController(activityItems: [jsonString],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
}
