import Foundation

class FileManagerModel {
    private let filemanager = FileManager.default
    
    func openFile(fileNamePath: String) -> String {
        var textArray: [String] = [String]()
        if let aStreamReader = LineReader(path: fileNamePath) {
            while let line = aStreamReader.nextLine{
                textArray.append(line)
            }
        }
        let text = textArray.map({$0}).joined(separator : "")
        textArray.removeAll()
        return text
    }
    
    func saveFile(fileUrl: String,
                  textFile: String,
                  fileName: String) {
        
        let path = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName).appendingPathExtension("ntp").path
        
        if fileUrl == "" {
            do {
                filemanager.createFile(atPath: path, contents: textFile.data(using: .utf8))
                print(openFile(fileNamePath: path), "Debug: error")
                }
        }
        if filemanager.fileExists(atPath: fileUrl) {
            do {
                try filemanager.removeItem(atPath: fileUrl)
                filemanager.createFile(atPath: fileUrl, contents: textFile.data(using: .utf8))
                print("ok2")
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func saveAs(filename: String,
                    content: String,
                    ext: String) -> String {
        let url = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension(ext)
        if filemanager.fileExists(atPath: url.path) {
            return "error"
        } else {
            filemanager.createFile(atPath: url.path, contents: content.data(using: .utf8), attributes: nil)
            return url.path
        }
        
    }
    
    func filelist() -> [String] {
        let files = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        let list = try? filemanager.contentsOfDirectory(atPath: files)
        return list!
    }
    
    func getPaths() -> [String: String] {
        let folderDocument = filemanager.urls(for: .documentDirectory,
                                              in: .userDomainMask)[0].path
        let list = try? filemanager.contentsOfDirectory(atPath: folderDocument)
        guard let list = list else { return [String: String]() }
        var listWithUrl: [String: String] = [:]
        for file in list {
            let key = folderDocument + "/" + file
            listWithUrl[key] = file
        }
        
        return listWithUrl
    }
    
    func getFileName(urlPath: String) -> String {
        let url = URL(string: urlPath)
        let name = url?.lastPathComponent
        return name ?? "Default.ntp"
    }
    
    func getPathExt(urlPath: String) -> String {
        let url = URL(string: urlPath)
        let name = url?.pathExtension
        return name ?? "ntp"
    }
    
    func getFileSize(at path: String) -> Int? {
        let attributes = try? filemanager.attributesOfItem(atPath: path)
        let fileSize = attributes?[.size] as? Int
        
        return fileSize
    }
}
