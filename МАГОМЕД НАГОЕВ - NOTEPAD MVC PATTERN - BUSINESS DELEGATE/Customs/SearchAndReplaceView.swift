//
//  SearchAndReplaceView.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Nargiza Beishekenova on 18/8/22.
//

import UIKit

class SearchAndReplaceView: UIView {
    private let horizontalStackView: UIStackView
    private let verticalStackView: UIStackView
    let searchTextField: UITextField
    let replaceTextField: UITextField
    let doneButton: UIButton
    var isReplacingEnabled: Bool {
        get {
            return !replaceTextField.isHidden
        }
        set {
            replaceTextField.isHidden = !newValue
        }
    }
    
    override init(frame: CGRect) {
        horizontalStackView = UIStackView()
        verticalStackView = UIStackView()
        searchTextField = UITextField()
        replaceTextField = UITextField()
        doneButton = UIButton(type: .close)
        super.init(frame: frame)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .top
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(doneButton)
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
        verticalStackView.addArrangedSubview(searchTextField)
        verticalStackView.addArrangedSubview(replaceTextField)
        
        searchTextField.returnKeyType = .search
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Найти"
        replaceTextField.borderStyle = .roundedRect
        replaceTextField.returnKeyType = .search
        replaceTextField.placeholder = "Заменить"
        doneButton.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
