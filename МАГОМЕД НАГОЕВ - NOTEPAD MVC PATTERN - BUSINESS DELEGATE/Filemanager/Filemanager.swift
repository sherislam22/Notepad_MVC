import Foundation
class FileManagerModel {
 
    func openFile(fileNamePath: String) -> String {
        var textArray: [String] = [String]()
        if let aStreamReader = LineReader(path: fileNamePath) {
            while let line = aStreamReader.nextLine{
                textArray.append(line)
            }
        }
        let text = textArray.map({$0}).joined(separator : "\n")
        textArray.removeAll()
        return text
    }

    func createFile(filename: String,content: String, ext: String) {
        let filemanager = FileManager.default
       
        let urls = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension(ext)
       
        do {
             filemanager.createFile(atPath: urls.path, contents: content.data(using: .utf8), attributes: nil)
        }
    }

}

