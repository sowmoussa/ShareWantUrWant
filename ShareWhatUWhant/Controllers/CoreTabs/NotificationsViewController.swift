//
//  NotificationsViewController.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import UIKit

class NotificationsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableV = UITableView()
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
