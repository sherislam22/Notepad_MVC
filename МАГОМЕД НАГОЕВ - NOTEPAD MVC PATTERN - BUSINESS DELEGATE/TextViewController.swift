//
//  TextViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class TextViewController: UIViewController {
    
    //MARK: - Properties
    private var textView: UITextView
    
    //MARK: - Initialize
    
    init() {
        textView = UITextView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
        view.backgroundColor = .lightGray
    }
    
    //MARK: - Methods
    private func setTextView() {
        let safeArea = view.safeAreaLayoutGuide
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.text = "I love iOS ❤️"
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            textView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 5),
            textView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -5)
        ])
    }
    
}
