////
////  DocumentBrowserViewController.swift
////  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
////
////  Created by Nargiza Beishekenova on 10/8/22.
////
//
//
    import UIKit

class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        allowsPickingMultipleItems = false
        allowsDocumentCreation = false
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            template = try? FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent("default.ntp")
            if template != nil {
                allowsDocumentCreation = FileManager.default.createFile(atPath: template! .path, contents: Data())
            }
        }
    }
    
    var template: URL?
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler
importHandler: @escaping(URL?, UIDocumentBrowserViewController.ImportMode) -> Void)
    {
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
        let textViewController = TextViewer()
        let navigationController = UINavigationController(rootViewController: textViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
//        let text = FileManagerModel.openFile(fileNamePath: documentURL.path)
        textViewController.document = TextDocument(fileURL: documentURL)
//        textViewController.updateTextView(text: text)
    }
    
}
