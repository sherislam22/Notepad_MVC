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

    func createFile(filename: String,
                    content: String,
                    ext: String) {
        let filemanager = FileManager.default
       
        let urls = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension(ext)
       
        do {
             filemanager.createFile(atPath: urls.path, contents: content.data(using: .utf8), attributes: nil)
        }
    }
    
    func createNtpURL() -> URL? {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("default.ntp")
        
        return url
    }

    func createNtpFile(url: URL) -> Bool {
        return FileManager.default.createFile(atPath: url .path, contents: Data())
    }
    
}

