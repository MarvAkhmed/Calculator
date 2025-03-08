//
//  ButtonCellCollectionViewCell.swift
//  Calculator
//
//  Created by Marwa Awad on 05.03.2025.
//

import UIKit

class ButtonCellCollectionView: UICollectionViewCell {
    
    //MARK: - Variables
    static var identifier: String = "ButtonCellCollectionView"
    private(set) var calculatorButton: CalculatorButtons!
    
    //MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Err"
        
        return label
    }()
    //MARK: - LifeCycle
    
    override func prepareForReuse() {  /// we only saw it's effect when there was ui updates
        super.prepareForReuse()
        self.titleLabel.removeFromSuperview()
    }
    //MARK: - Configure
    public func configure(with calculatorButton: CalculatorButtons) {
        self.calculatorButton = calculatorButton
        self.titleLabel.text = calculatorButton.title
        self.backgroundColor = calculatorButton.color
        
        switch calculatorButton {
        case .allClear, .plusMinus, .percentage:
            self.titleLabel.textColor = . black
        default:
            self.titleLabel.textColor = .white
        }
        self.setupUI()
    }
    //MARK: - Setup UI for a circular buttons titles
    private func setupUI() {
        self.addSubview(self.titleLabel)
        self.layer.cornerRadius = 36
        let extraSpace = self.frame.width - self.frame.height
        switch self.calculatorButton {
        case let .number(int) where int == 0:
            NSLayoutConstraint.activate([
                self.titleLabel.heightAnchor.constraint(equalToConstant: self.frame.height),
                self.titleLabel.widthAnchor.constraint(equalToConstant: self.frame.height),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.titleLabel.trailingAnchor.constraint(equalTo : self.trailingAnchor, constant: -extraSpace),
            ])
        default:
            NSLayoutConstraint.activate([
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
                self.titleLabel.widthAnchor.constraint(equalTo : self.widthAnchor),
            ])
        }
    }
}
//    //MARK: - Setup UI to make it alil bit round
//    private func setupUI() {
//        self.addSubview(self.titleLable)
//        self.layer.cornerRadius = (self.frame.size.width/5) / 3
//
//        NSLayoutConstraint.activate([
//            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
//            self.titleLabel.widthAnchor.constraint(equalTo : self.widthAnchor),
//        ])
//
//    }
//}
///MARK: - I dentifier
//extension UICollectionViewCell {
//    static var identifier: String {
//        return String(describing: self)
//    }
//}

//MARK: -TODO:
//1- study UICollectionViewCell
//2- study UICollectionViewDelegateFlowLayout
//3- study UICollectionReusableView
//4- study MVVM
//5- study prepareForReuse
//6- study UICollectionViewDelegate, UICollectionViewDataSource

