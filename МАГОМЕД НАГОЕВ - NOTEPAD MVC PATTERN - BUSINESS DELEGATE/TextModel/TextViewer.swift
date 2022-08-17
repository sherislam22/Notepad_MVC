//
//  TextViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class TextViewer: UIViewController {
    //MARK: - Mode
    enum Mode {
        case `default`
        case searchAndReplace
    }

    //MARK: - Properties
    private let stackView: UIStackView
    private let textView: UITextView
    private let searchAndReplaceView: SearchAndReplaceView
    private let searchAndReplaceButtonsView: SearchAndReplaceButtonsView
    private var textController: TextController?
    private var stackViewBottomConstraint: NSLayoutConstraint?
    let notePadToolBar: NotePadToolBar
    private let notepadView: UIImageView
    
    var mode: Mode = .default {
        didSet {
            switch mode {
            case .default:
                searchAndReplaceView.isHidden = true
                searchAndReplaceButtonsView.isHidden = true
            case .searchAndReplace:
                searchAndReplaceView.isHidden = false
                searchAndReplaceButtonsView.isHidden = false
            }
        }
    }
    
    
    //MARK: - Initialize
    init(router: RouterProtocol) {
        stackView = UIStackView()
        textView = UITextView()
        searchAndReplaceView = SearchAndReplaceView()
        searchAndReplaceButtonsView = SearchAndReplaceButtonsView()
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
        setupStackView()
        view.backgroundColor = .white
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
        textView.inputAccessoryView = notePadToolBar
        setnavigationBar()
        setZoom()
        mode = .searchAndReplace
        setupSearchAndReplaceView()
    }
    
    //MARK: - Methods
    
    func setZoom() {
        textView.minimumZoomScale = 0.5
        textView.maximumZoomScale = 2.0
    }
    
    func setnavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(menuButtonTapped))
    }
    
    private func setupStackView() {
        let safeArea = view.safeAreaLayoutGuide
        
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        stackViewBottomConstraint = stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        guard let stackViewBottomConstraint = stackViewBottomConstraint else { return }
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: notepadView.bottomAnchor, constant: 0),
            stackViewBottomConstraint,
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -5)
        ])
        
        textView.backgroundColor = .white
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        searchAndReplaceView.translatesAutoresizingMaskIntoConstraints = false
        searchAndReplaceButtonsView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(searchAndReplaceView)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(searchAndReplaceButtonsView)
    }
    
    func setupSearchAndReplaceView() {
        searchAndReplaceView.searchTextField.delegate = self
        
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
        //print("menuButtonTapped")
    }
}

// MARK: - Keyboard
extension TextViewer {
    
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
        if stackViewBottomConstraint?.constant == 0 {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            stackViewBottomConstraint?.constant = -keyboardHeight
            
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        stackViewBottomConstraint?.constant = 0
        view.layoutIfNeeded()
    }
}

extension TextViewer: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textController?.find(textField.text ?? "")
        return true
    }
}

class SearchAndReplaceView: UIView {
    private let horizontalStackView: UIStackView
    private let verticalStackView: UIStackView
    let searchTextField: UITextField
    let replaceTextField: UITextField
    private let doneButton: UIButton
    
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
        replaceTextField.borderStyle = .roundedRect
        replaceTextField.returnKeyType = .search
        doneButton.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchAndReplaceButtonsView: UIView {
    private let horizontalStackView: UIStackView
    private let backButton: UIButton
    private let nextButton: UIButton
    private let replaceButton: UIButton
    private let replaceAllButton: UIButton
    
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
