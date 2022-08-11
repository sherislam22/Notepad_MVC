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
    //MARK: Toolbar's properties
    var toolBar = UIToolbar()
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var tempToolBarItems = [UIBarButtonItem]()
    var goToRight: Bool = false
    
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
        setButton()
        setupToolBar()
        toolBar.setItems(tempToolBarItems, animated: false)
        setnavigationBar()
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
    
    func setupToolBar() {
        changeStateOfToolbar()
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
    }
    
    func changeStateOfToolbar() {
       
        if !goToRight {
            tempToolBarItems.removeAll()
            let cut = UIBarButtonItem(image: UIImage(systemName: "scissors"), style: .plain, target: self, action: nil)
            let undo = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.backward.circle"), style: .plain, target: self, action: nil)
            let redo = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.forward.circle"), style: .plain, target: self, action: nil)
            let copy = UIBarButtonItem(image: UIImage(systemName: "doc.on.doc"), style: .plain, target: self, action: nil)
            let remove = UIBarButtonItem(image: UIImage(systemName: "trash.slash.circle"), style: .plain, target: self, action: nil)
            let rightArrow = UIBarButtonItem(image: UIImage(systemName: "arrow.right.to.line"), style: .plain, target: self, action: #selector(rightArrowTapped))
            
            [cut, flexibleSpace, undo, flexibleSpace, redo, flexibleSpace, copy, flexibleSpace, remove, flexibleSpace, rightArrow].forEach { tempToolBarItems.append($0) }
        } else {
            tempToolBarItems.removeAll()
            let leftArrow = UIBarButtonItem(image: UIImage(systemName: "arrow.left.to.line"), style: .plain, target: self, action: #selector(leftArrowTapped))
            let replace = UIBarButtonItem(image: UIImage(systemName: "repeat.circle"), style: .plain, target: self, action: nil)
            let find = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
            let goTo = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: self, action: nil)
            let selectAll = UIBarButtonItem(image: UIImage(systemName: "rectangle.fill.badge.checkmark"), style: .plain, target: self, action: nil)
            let timeAndDate = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: nil)
            
            [leftArrow, flexibleSpace, replace, flexibleSpace, find, flexibleSpace, goTo, flexibleSpace, selectAll, flexibleSpace, timeAndDate, flexibleSpace].forEach { tempToolBarItems.append($0) }
        }
    }
    
    @objc func rightArrowTapped(_ sender: UIButton) {
        goToRight = !goToRight
        changeStateOfToolbar()
        toolBar.setItems(tempToolBarItems, animated: true)
    }
    
    @objc func leftArrowTapped(_ sender: UIButton) {
        goToRight = !goToRight
        changeStateOfToolbar()
        toolBar.setItems(tempToolBarItems, animated: true)
    }
}
