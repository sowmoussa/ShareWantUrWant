//
//  ViewController.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {

    private let tableView: UITableView = {
        let tableV = UITableView()
        tableV.register(IGPostCell.self, forCellReuseIdentifier: IGPostCell.identifier)
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    private func handleNotAuthenticated() {
        // Check Auth Status
        if Auth.auth().currentUser == nil {
            // show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGPostCell.identifier, for: indexPath) as! IGPostCell
        return cell
    }
}
