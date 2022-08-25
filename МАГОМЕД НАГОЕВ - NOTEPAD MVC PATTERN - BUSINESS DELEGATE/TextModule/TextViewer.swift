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
    let stackView: UIStackView
    let textView: UITextView
    let notePadToolBar: NotePadToolBar
    let searchAndReplaceView: SearchAndReplaceView
    let searchAndReplaceButtonView: SearchAndReplaceButtonsView
    
    private var stackViewBottomConstraint: NSLayoutConstraint?
    
    private var urlFile: URL
    public var filename: String?
    
    var ranges: [NSRange] {
        didSet {
            let isEnabled = !ranges.isEmpty
            searchAndReplaceButtonView.backButton.isEnabled = isEnabled
            searchAndReplaceButtonView.nextButton.isEnabled = isEnabled
            searchAndReplaceButtonView.replaceButton.isEnabled = isEnabled
            searchAndReplaceButtonView.replaceAllButton.isEnabled = isEnabled
        }
    }
    var selectedRangeIndex: Int
    
    var mode: Mode = .default {
        didSet {
            switch mode {
            case .default:
                searchAndReplaceView.isHidden = true
                searchAndReplaceButtonView.isHidden = true
                navigationController?.setNavigationBarHidden(false, animated: true)
                notepadView.isHidden = false
                ranges = []
                updateHighlighting()
            case .searchAndReplace:
                searchAndReplaceView.isHidden = false
                searchAndReplaceButtonView.isHidden = false
                navigationController?.setNavigationBarHidden(true, animated: true)
                notepadView.isHidden = true
                textView.resignFirstResponder()
            }
        }
    }
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
        notePadToolBar.notePadToolbarDelegate = self
        
        setupZoom()
        
        ranges = []
  
        mode = .default
    }
    
    
    
    func dataAndTime() {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let data = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        updateDataAndTime(text:" \n    \n    \(year)/\(month)/\(data) - \(hour):\(minute)")
    }
    
    func updateTextViewFont(font: UIFont) {
        textView.font = font
    }
    
    func selectWholeText() {
        textView.selectAll(self)
    }
    
    func cutSelectedText(text: String) {
        textView.cut(text)
    }
    
    func pasteCopiedText(text: String) {
        textView.paste(text)
    }

    //passes the value of the selected text to the textToCopy in NotePadToolBar()
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if let range = textView.selectedTextRange {
            notePadToolBar.selectedText = textView.text(in: range) ?? ""
        }
        return super.canPerformAction(action, withSender: sender)
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
    
    var isData = false
    public func updateDataAndTime(text: String) {
        if !isData {
            textView.text += text
            isData = true
        } else {
            textView.text.removeLast(text.count)
            isData = false
        }
    }
    
    public func getText() -> String {
        return textView.text
    }
    
    public func getFont() -> UIFont {
        if let font = textView.font {
            return font
        }
        return UIFont()
    }
    
    public func updateTitle(fileTitle: String) {
        title = fileTitle
    }
    
    @objc func menuButtonTapped(_ sender: UIBarButtonItem) {
        textController?.showMenu(barButtonItem: sender)
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        mode = .default
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textController?.careTaker.save()
    }
}

