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
    public var textController: TextController?
    private var textViewBottomConstraint: NSLayoutConstraint?
    let notePadToolBar: NotePadToolBar
    private let notepadView: UIImageView
    private var urlFile: URL
    public var filename: String?
    //MARK: - Initialize
    
    init() {
        textView = UITextView()
        notePadToolBar = NotePadToolBar(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        self.urlFile = URL(fileURLWithPath: "")
        notepadView = UIImageView()
        notepadView.image = UIImage(named: "notepad")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        setImageView()
        setTextView()
        view.backgroundColor = .white
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
        notePadToolBar.translatesAutoresizingMaskIntoConstraints = false
        textView.inputAccessoryView = notePadToolBar
        setnavigationBar()
        setZoom()
        setupNavigationItem()

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
        textView.textColor = .black
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

    
    @objc func menuButtonTapped() {
        textController?.showMenu()
    }
    
    func didTapSaveButton(){
            let alert = UIAlertController(title: "Name the file", message: nil, preferredStyle: .alert)
    
            let confirmAction = UIAlertAction(title: "Save", style: .default) { _ in
                if let txtField = alert.textFields?.first, let text = txtField.text {
                    // operations
                    self.filename = text
                    self.textController?.saveAs()
                    
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            alert.view.addSubview(UIView())
            alert.addTextField { (textField) in
                textField.placeholder = "File name"
            }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
    
            present(alert, animated: true, completion: nil)
     
        
    }
    
    func getFilename() -> String {
        return self.filename ?? "Default"
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
    
    func setupNavigationItem() {
        let undo = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.backward.circle"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(undoDidTap))
    
        let redo = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.forward.circle"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(redoDidTap))
        
        navigationItem.leftBarButtonItems
        = [undo,
           redo]
    }
    
    @objc
    func undoDidTap() {
        textController?.careTaker.undo()
    }
    
    @objc
    func redoDidTap() {
        textController?.careTaker.redo()

    }
}

//MARK: - Add undo and redo command
extension TextViewer: TextWriterProtocol {
    func saveState() -> TextMemento {
        TextMemento(text: textView.text,
                    textFont: textView.font ?? UIFont())
    }
    
    func restore(state: TextMemento) {
        updateTextView(text: state.text)
    }
}

extension TextViewer: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == " " {
            textController?.careTaker.save()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textController?.careTaker.save()
    }
}
