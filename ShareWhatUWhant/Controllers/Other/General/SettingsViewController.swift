//
//  SettingsViewController.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (()->Void)
}

final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableV = UITableView(frame: .zero,
                                 style: .grouped)
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableV
    }()
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func didTapLogout() {
        let actionSheet = UIAlertController(title: "Logout", message: "Are you sure ?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
            AuthManager.shared.logOut { (succes) in
                DispatchQueue.main.async {
                    if succes {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: false) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        fatalError("Could not log out")
                    }
                }
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends() {
        // Show share sheet
    }
    private func saveOriginalPosts() {
        
    }
    
    enum SettingsUrlType {
        case terms, privacy, help
    }
    private func openUrl(type: SettingsUrlType) {
        let urlString: String
        switch type {
            case .terms: urlString = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
            case.privacy: urlString = "https://help.instagram.com/519522125107875"
            case.help: urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self!.didTapEditProfile()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self!.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self!.saveOriginalPosts()
            }
        ])
        data.append([
            SettingCellModel(title: "Terms Of Service") { [weak self] in
                self!.openUrl(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self!.openUrl(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self!.openUrl(type: .help)
            }
        ])
        data.append([
            SettingCellModel(title: "Logout") { [weak self] in
                self!.didTapLogout()
            }
        ])
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.section][indexPath.row].handler()
    }
}
