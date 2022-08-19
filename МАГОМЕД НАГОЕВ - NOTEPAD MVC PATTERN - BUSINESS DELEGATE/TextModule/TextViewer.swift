//
//  TextViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class TextViewer: UIViewController {
    
    //MARK: - Properties
    public var textController: TextController?
    
    private let notepadView: UIImageView
    private let stackView: UIStackView
    private let textView: UITextView
    let notePadToolBar: NotePadToolBar
    private let searchAndReplaceView: SearchAndReplaceView
    private let searchAndReplaceButtonView: SearchAndReplaceButtonsView
    
    private var stackViewBottomConstraint: NSLayoutConstraint?
    
    private var urlFile: URL
    public var filename: String?
    
    private var ranges: [NSRange]
    private var selectedRangeIndex: Int
    
    //MARK: - Initialize
    
    init() {
        notepadView = UIImageView(image: UIImage(named: "notepad"))
        stackView = UIStackView()
        textView = UITextView()
        notePadToolBar = NotePadToolBar(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        searchAndReplaceView = SearchAndReplaceView()
        searchAndReplaceButtonView = SearchAndReplaceButtonsView()
        urlFile = URL(fileURLWithPath: "")
        ranges = []
        selectedRangeIndex = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupImageView()
        setupStackView()
        setupTextView()
        setupSearchAndReplaceView()
        setupSearchAndReplaceButtonView()
        setupDismissKeyboardGesture()
        setupKeyboardFrame()
        setupNavigationItem()
        
        setupZoom()
        
    }
    //MARK: - SetupMethods
    private func setupImageView() {
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
    
    private func setupStackView() {
        let safeArea = view.safeAreaLayoutGuide
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewBottomConstraint = view.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0)
        stackViewBottomConstraint?.priority = .defaultHigh
        let requiredBottomConstraint = safeArea.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor)
        
        guard let stackViewBottomConstraint = stackViewBottomConstraint else { return }
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: notepadView.bottomAnchor, constant: 0),
            stackViewBottomConstraint,
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -5),
            requiredBottomConstraint
        ])
        
        stackView.axis = .vertical
    }
    
    private func setupTextView() {
        textView.delegate = self
        
        textView.backgroundColor = .white
        textView.textColor = .black
       
        stackView.addArrangedSubview(textView)
        
        notePadToolBar.translatesAutoresizingMaskIntoConstraints = false
        textView.inputAccessoryView = notePadToolBar
    }
    
    private func setupSearchAndReplaceView() {
        stackView.insertArrangedSubview(searchAndReplaceView, at: 0)
        searchAndReplaceView.searchTextField.delegate = self
        searchAndReplaceView.replaceTextField.delegate = self
    }
    
    private func setupSearchAndReplaceButtonView() {
        stackView.addArrangedSubview(searchAndReplaceButtonView)
        searchAndReplaceButtonView.backButton.addTarget(self,
                                                        action: #selector(jumpToPreviousSearch),
                                                        for: .touchUpInside)
        searchAndReplaceButtonView.nextButton.addTarget(self,
                                                        action: #selector(jumpToNExtSearch),
                                                        for: .touchUpInside)
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc private func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setupKeyboardFrame() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
        
        navigationItem.leftBarButtonItems = [undo, redo]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(menuButtonTapped))
    }
    
    func setupZoom() {
        textView.minimumZoomScale = 0.5
        textView.maximumZoomScale = 2.0
    }
    
    
    //MARK: - Methods
    
    
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
    
    func highlightRanges(_ ranges: [NSRange]) {
        self.ranges = ranges
        updateHighlighting()
    }
    
    func updateHighlighting() {
        let newAttributedText = NSMutableAttributedString(string: textView.text)
        ranges.enumerated().forEach { index, range in
            let color = index == selectedRangeIndex ? UIColor.green : UIColor.yellow
            newAttributedText.addAttribute(.backgroundColor, value: color, range: range)
        }
        textView.attributedText = newAttributedText
    }
    @objc func jumpToPreviousSearch() {
        guard !ranges.isEmpty else { return }
        selectedRangeIndex -= 1
        if selectedRangeIndex < 0 {
            selectedRangeIndex = ranges.count - 1
        }
        updateHighlighting()
    }
    
    @objc func jumpToNExtSearch() {
        guard !ranges.isEmpty else { return }
        selectedRangeIndex += 1
        if selectedRangeIndex >= ranges.count {
            selectedRangeIndex = 0
        }
        updateHighlighting()
    }
}

extension TextViewer {
    
    // MARK: - Keyboard
    
    @objc private func keyboardWillChangeFrame(sender: Notification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let intersection = view.frame.intersection(keyboardFrame.cgRectValue)
        stackViewBottomConstraint?.constant = intersection.height
        view.layoutIfNeeded()
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
extension TextViewer: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == searchAndReplaceView.searchTextField || textField == searchAndReplaceView.replaceTextField),
            let text = searchAndReplaceView.searchTextField.text {
            textController?.search(text)
        }
        return true
    }
}
