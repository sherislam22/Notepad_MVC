import Foundation
class FileManagerModel {
    // принимает url от IUDocumentPickerViewController в делегате
    //IUDocumentPickerViewDelegate получаете url и вызываете этот метод
    static func openFile(fileNamePath: String) -> String {
        var textArray: [String] = [String]()
<<<<<<< Updated upstream
        let url = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileNamePath)
        if let aStreamReader = LineReader(path: url.path) {
=======
        if let aStreamReader = LineReader(path: fileNamePath) {
>>>>>>> Stashed changes
            while let line = aStreamReader.nextLine{
                textArray.append(line)
            }
        }
        let text = textArray.map({$0}).joined(separator : "\n")
        textArray.removeAll()
        return text
    }

    static func createFile(filename: String,content: String, ext: String) {
        let filemanager = FileManager.default
       
        let urls = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension(ext)
       
        do {
             filemanager.createFile(atPath: urls.path, contents: content.data(using: .utf8), attributes: nil)
        }
    }
    static func listFiles() -> [String] {
           let fileManager = FileManager.default
        var lst = [String]()
           let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
           do {
               guard let items = try? fileManager.contentsOfDirectory(atPath: path) else {
                   
                  return [""]
               }
               for item in items {
                   let url = "\(item)"
                   lst.append(url)
               }
           }
       return lst
       }

}

