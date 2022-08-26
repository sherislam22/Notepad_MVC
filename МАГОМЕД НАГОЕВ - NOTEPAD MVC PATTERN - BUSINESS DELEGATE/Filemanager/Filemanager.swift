import Foundation

class FileManagerModel {
    let filemanager = FileManager.default
    
    func openFile(_ fileUrl: URL) -> String {
        var textArray: [String] = [String]()
        if let aStreamReader = LineReader(path: fileUrl.path) {
            while let line = aStreamReader.nextLine{
                textArray.append(line)
            }
        }
        let text = textArray.map({$0}).joined(separator : "")
        textArray.removeAll()
        return text
    }
        
    func readFileByCharacter(_ fileUrl: URL) -> String {
        do {
            return try (CharacterReader(fileUrl: fileUrl).read())!
        } catch {
            print("Could not open the file")
            return ""
        }
    }

    func generateFileUrl(fileName: String) -> URL {
        var url = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        if url.pathExtension.isEmpty {
            url.appendPathExtension("ntp")
        }
        return url
    }

    func save(fileUrl: URL, content: String) {
        filemanager.createFile(atPath: fileUrl.path, contents: content.data(using: .utf8))
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
    
    func fileExists(_ fileUrl: URL) -> Bool {
        return filemanager.fileExists(atPath: fileUrl.path)
    }
}
