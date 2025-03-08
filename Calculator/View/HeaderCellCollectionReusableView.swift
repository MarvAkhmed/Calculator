//
//  ButtonCellCollectionReusableView.swift
//  Calculator
//
//  Created by Marwa Awad on 05.03.2025.
//

import UIKit

class HeaderCellCollectionReusableView: UICollectionReusableView {
    static let identifier = "ButtonCellCollectionReusableView"
    
    //MARK: - UI Components
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.text = "Error"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: -  LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cell Configurations
    public func configure(_ currentCalcText: String){
        self.label.text = currentCalcText
    }
    //MARK: -  UI Setup
    private func setupUI() {
        self.backgroundColor = .black
        self.addSubview(self.label)
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
//MARK: - TODO:
//1 - study layoutMarginsGuide
//2- study private(set) var

