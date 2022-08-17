import Foundation
class FileManagerModel {
    let filemanager = FileManager.default
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
    
    func saveFile(fileUrl: String, text: String) {
        print(fileUrl)
        let path = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Documents").appendingPathComponent("test2").appendingPathExtension("ntp").path
        if fileUrl == "" {
            do {
                filemanager.createFile(atPath: path, contents: text.data(using: .utf8))
                let str = try? String(contentsOfFile: path)
                print(str ?? "error", "ook")
            } 
        }
        if filemanager.fileExists(atPath: fileUrl) {
            do {
                try filemanager.removeItem(atPath: fileUrl)
                filemanager.createFile(atPath: fileUrl, contents: text.data(using: .utf8))
                print("ok2")
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func createFile(filename: String,
                    content: String,
                    ext: String) -> URL
    {
        let url = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension(ext)
        filemanager.createFile(atPath: url.path, contents: content.data(using: .utf8), attributes: nil)
        return url
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
