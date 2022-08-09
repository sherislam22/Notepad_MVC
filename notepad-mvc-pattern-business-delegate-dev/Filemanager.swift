import Foundation
class FileManagerModel {
    // принимает url от IUDocumentPickerViewController в делегате
    //IUDocumentPickerViewDelegate получаете url и вызываете этот метод
    static func openFile(fileNamePath: String) -> String {
        let filemanager = FileManager.default
        let path = filemanager.contents(atPath: fileNamePath)
        let open =  String(data: path ?? Data(), encoding: .utf8)
        return open ?? "error"
    }

    static func createFile(filename: String,content: String, ext: String) {
        let filemanager = FileManager.default
       
        let urls = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension(ext)
       
        do {
             filemanager.createFile(atPath: urls.path, contents: content.data(using: .utf8), attributes: nil)
            print("create file: \(urls.lastPathComponent)")
        }
    }
    static func listFiles() -> [String] {
           let fileManager = FileManager.default
        var lst = [String]()
           let path = NSSearchPathForDirectoriesInDomains(.allApplicationsDirectory, .userDomainMask, true)[0]
        
           do {
               guard let items = try? fileManager.contentsOfDirectory(atPath: path) else {
                   print("no files found")
                  return [""]
               }
               for item in items {
                   let url = "\(item)"
                   lst.append(url)
               }
           }
         print("Путь: \(path) \n ==================")
       return lst
       }

}
