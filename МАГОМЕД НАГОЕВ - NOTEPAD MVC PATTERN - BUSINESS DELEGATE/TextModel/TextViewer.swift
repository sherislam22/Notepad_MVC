//
//  TextViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class TextViewer: UIViewController {
    
    //MARK: - Properties
    private var textView: UITextView
    private var textController: TextController?
    private var textViewBottomConstraint: NSLayoutConstraint?
    var document: TextDocument?
    
    //MARK: - Initialize
    
    init() {
        textView = UITextView()
        super.init(nibName: nil, bundle: nil)
        textController = TextController(textViewer: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
        view.backgroundColor = .lightGray
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
        self.navigationController?.isNavigationBarHidden = false
//        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.textView.text = self.document?.text
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    //MARK: - Methods
    
    func setButton() {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        let closeButton = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = closeButton
        
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    private func setTextView() {
        let safeArea = view.safeAreaLayoutGuide
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        
        textViewBottomConstraint = textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        guard let textViewBottomConstraint = textViewBottomConstraint else { return }
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            textViewBottomConstraint,
            textView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 5),
            textView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -5)
        ])
    }
    
    public func updateTextView(text: String) {
        textView.text = text
    }
    
    public func updateTitle(fileTitle: String) {
        title = fileTitle
    }
}

extension TextViewer {

    // MARK: - Keyboard
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        if textViewBottomConstraint?.constant == 0 {

            let keyboardHeight = keyboardFrame.cgRectValue.height
            textViewBottomConstraint?.constant = -keyboardHeight

            view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        textViewBottomConstraint?.constant = 0
        view.layoutIfNeeded()
    }
    
    @objc func close() {
        presentingViewController?.dismiss(animated: true)
    }
}
