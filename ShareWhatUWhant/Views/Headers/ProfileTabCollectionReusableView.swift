//
//  ProfileTabCollectionReusableView.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 25/04/2021.
//

import UIKit

class ProfileTabCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
