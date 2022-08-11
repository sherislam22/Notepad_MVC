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
        setnavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textController?.openDocument()
    }

    //MARK: - Methods
    
    func setnavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .white
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
    
    public func getText() -> String {
        return textView.text
    }
    
    public func updateTitle(fileTitle: String) {
        title = fileTitle
    }
    
    public func getDocumentURL(url: URL) {
        textController?.createDocument(documentURL: url)
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
    
    @objc func save() {
        presentingViewController?.dismiss(animated: true)
        textController?.saveDocument()
    }
}
