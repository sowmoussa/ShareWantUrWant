//
//  EditProfileViewController.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 23/04/2021.
//

import UIKit

struct  EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController, UITableViewDataSource {

    private let tableView: UITableView = {
        let tableV = UITableView()
        tableV.register(FormCell.self, forCellReuseIdentifier: FormCell.identifier)
        return tableV
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        tableView.tableHeaderView = createTableHeaderView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureModels() {
        let sectionLabel = ["Email", "Phone", "Gender"]
        var section1 = [EditProfileFormModel]()
        for label in sectionLabel {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)", value: nil)
            section1.append(model)
        }
        models.append(section1)
    }
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormCell.identifier, for: indexPath) as! FormCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    func createTableHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4.0).integral)
        let size = header.height/1.5
        let profilPhoto = UIButton(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: size,
                                                 height: size))
        header.addSubview(profilPhoto)
        profilPhoto.layer.masksToBounds = true
        profilPhoto.layer.cornerRadius = size/2.0
        profilPhoto.addTarget(self, action: #selector(didTapProfilButton), for: .touchUpInside)
        profilPhoto.tintColor = .white
        profilPhoto.setBackgroundImage(UIImage(named: "person.fill"), for: .normal)
        profilPhoto.layer.borderWidth = 1.0
        profilPhoto.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    // MARK: - Action
    @objc func didTapProfilButton() {
        
    }
    @objc private func didTapSave() {
        // sacve info to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change Profile Picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { (_) in
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Choose from library",
                                            style: .default,
                                            handler: { (_) in
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .default,
                                            handler: nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
}

extension EditProfileViewController: FormCellDelegate {
    func formCell(_ cell: FormCell, didUpdateField updatedValue: EditProfileFormModel) {
        print("Value updated is \(updatedValue.value ?? nil)")
    }
    
    
}
