//
//  TextViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class TextViewer: UIViewController {
    
    //MARK: - Properties
    private let textView: UITextView
    private var textController: TextController?
    private var textViewBottomConstraint: NSLayoutConstraint?
    var document: TextDocument?
    let notePadToolBar: NotePadToolBar
    private let notepadView: UIImageView

    //MARK: - Initialize
    
    init(router: RouterProtocol) {
        textView = UITextView()
        notePadToolBar = NotePadToolBar()
        
        notepadView = UIImageView()
        notepadView.image = UIImage(named: "notepad")
        super.init(nibName: nil, bundle: nil)

        textController = TextController(textViewer: self,
                                        router: router)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setTextView()
        view.backgroundColor = .white
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
        textView.inputAccessoryView = notePadToolBar
        setnavigationBar()
        textController?.openDocument()
        setZoom()
    }

    //MARK: - Methods
    
    func setZoom() {
        textView.minimumZoomScale = 0.5
        textView.maximumZoomScale = 2.0
    }
    
    func setnavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(menuButtonTapped))
    }
    
    private func setTextView() {
        let safeArea = view.safeAreaLayoutGuide
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        
        textViewBottomConstraint = textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        guard let textViewBottomConstraint = textViewBottomConstraint else { return }
        
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: notepadView.bottomAnchor, constant: 0),
            textViewBottomConstraint,
            textView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 5),
            textView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -5)
        ])
    }
    
    func setImageView() {
        let safeArea = view.safeAreaLayoutGuide

        notepadView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(notepadView)
        NSLayoutConstraint.activate([
            notepadView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            notepadView.heightAnchor.constraint(equalToConstant: 18),
            notepadView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            notepadView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0)
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
    
    @objc func close() {
        presentingViewController?.dismiss(animated: true)
    }
    
    @objc func menuButtonTapped() {
        textController?.router.pushContentMenu()
        //print("menuButtonTapped")
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
}
