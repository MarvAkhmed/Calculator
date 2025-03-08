//
//  ViewController.swift
//  Calculator
//
//  Created by Marwa Awad on 05.03.2025.
//

import UIKit

class CalculatorViewController: UIViewController {

    //MARK: - Variables
    let viewModel: CalculatorViewModel
    
    //MARK: - UI components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ButtonCellCollectionView.self, forCellWithReuseIdentifier: ButtonCellCollectionView.identifier)
        collectionView.register(HeaderCellCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCellCollectionReusableView.identifier)
        return collectionView
    }()

    //MARK: - LifeCycle
    init(_ viewModel: CalculatorViewModel = CalculatorViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.setupUI()
        
    }

    //MARK: - UI Setup
    private func setupUI() {
        view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint (equalTo: self.view.bottomAnchor),
        ])
    }
}

//MARK: - CollectionView Methods
extension CalculatorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Section Header Cell
     
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCellCollectionReusableView.identifier, for: indexPath) as? HeaderCellCollectionReusableView else {
            fatalError("failed to dequeue HeaderCell in CalculatorViewController")
        }
        header.configure(self.viewModel.calculatorHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let totalCellHeight = (self.view.frame.size.width) // grapping the heght of all the cells
        let totalVerticalCellSpacing = CGFloat (10*4) // the total heght of the spacing between the 4 buttons
        let window = view.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0 // here we grapped the top and bottom insets
        
        let availableScreenHight = self.view.frame.size.height - topPadding - bottomPadding //  
         
        let headerHeight = availableScreenHight - totalCellHeight - totalVerticalCellSpacing
        return CGSize(width: self.view.frame.size.width, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //MARK: - Normal Cells (Buttons)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calculatorButtonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCellCollectionView.identifier, for: indexPath) as? ButtonCellCollectionView  else {
            fatalError("failed to dequeue ButtonCell in CalculatorViewController")
        }
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        cell.configure(with: calculatorButton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        let widthSize = self.view.frame.size .width / 5
        
        switch calculatorButton {
            // here we can make case let or we can remove that let and put in inside the () an make it .number(let int)
        case let .number(int) where int == 0:
            return CGSize(width: widthSize * 2.3 , height: widthSize )
        default :
            return CGSize(width: widthSize, height: widthSize )
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (self.view.frame.width / 5)/3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = self.viewModel.calculatorButtonCells[indexPath.row]
        print(buttonCell.title)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
