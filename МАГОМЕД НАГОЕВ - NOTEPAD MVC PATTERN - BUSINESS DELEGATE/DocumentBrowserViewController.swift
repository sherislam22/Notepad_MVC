////
////  DocumentBrowserViewController.swift
////  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
////
////  Created by Nargiza Beishekenova on 10/8/22.
////
//
//
    import UIKit

class DocumentBrowserViewController: UIDocumentBrowserViewController,
                                     UIDocumentBrowserViewControllerDelegate {
    private var template: URL?
    private var fileManager: FileManagerModel
    
    init() {
        fileManager = FileManagerModel()
        super.init(forOpening: [.text])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        allowsPickingMultipleItems = false
        allowsDocumentCreation = false
        createDefaultFile()
    }
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    private func createDefaultFile() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            template = fileManager.createNtpURL()

            if let templateURL = template {
                allowsDocumentCreation = fileManager.createNtpFile(url: templateURL)
            }
        }
    }

    func documentBrowser(_ controller:
                         UIDocumentBrowserViewController,
                         didRequestDocumentCreationWithHandler importHandler:
                         @escaping(URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        importHandler(template, .copy)
    }

    func documentBrowser(_ controller:UIDocumentBrowserViewController,
                         didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        presentDocument(at: sourceURL)
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController,
                         didImportDocumentAt sourceURL: URL,
                         toDestinationURL destinationURL: URL){
        presentDocument(at: destinationURL)
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?){
        print("error" + (String(describing: error)))
    }

    // MARK: Document Presentation

    func presentDocument(at documentURL: URL){
//        let textViewController = TextViewer()
//
//        let navigationController = UINavigationController(rootViewController: textViewController)
//        navigationController.modalPresentationStyle = .fullScreen
//
//        present(navigationController, animated: true)
//
//        textViewController.getDocumentURL(url: documentURL)

    }
    
}
