//
//  SearchAndReplaceButtonsView.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Nargiza Beishekenova on 18/8/22.
//

import UIKit

class SearchAndReplaceButtonsView: UIView {
    private let horizontalStackView: UIStackView
    let backButton: UIButton
    let nextButton: UIButton
    let replaceButton: UIButton
    let replaceAllButton: UIButton
    
    override init(frame: CGRect) {
        horizontalStackView = UIStackView()
        backButton = UIButton(type: .system)
        nextButton = UIButton(type: .system)
        replaceButton = UIButton(type: .system)
        replaceAllButton = UIButton(type: .system)
        super.init(frame: frame)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .bottom
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        ])
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.addArrangedSubview(backButton)
        horizontalStackView.addArrangedSubview(replaceButton)
        horizontalStackView.addArrangedSubview(replaceAllButton)
        horizontalStackView.addArrangedSubview(nextButton)
        
        backButton.setImage(UIImage(systemName: "chevron.backward.circle"), for: .normal)
        nextButton.setImage(UIImage(systemName: "chevron.forward.circle"), for: .normal)
        replaceButton.setTitle("Заменить", for: .normal)
        replaceAllButton.setTitle("Заменить все", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
