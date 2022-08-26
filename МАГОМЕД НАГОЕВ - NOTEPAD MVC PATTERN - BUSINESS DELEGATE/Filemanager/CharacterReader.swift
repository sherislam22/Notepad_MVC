import Foundation

class CharacterReader {
    let fileUrl: URL
    
    init(fileUrl: URL) {
        self.fileUrl = fileUrl
    }
    
    func read() throws -> String? {
        do {
            let handle = try FileHandle(forReadingFrom: fileUrl)
            defer {
                try? handle.close()
            }
            
            var data = try handle.read(upToCount: 1)
            var array = [UInt8]()
            
            while data != nil && !data!.isEmpty {
                array.append(data![0])
                data = try handle.read(upToCount: 1)
            }
            
            return String(bytes: array, encoding: .utf8)
        } catch {
            print("FileHandle could not be created")
            return nil
        }
    }
}
