import Foundation
class LineReader {

    let path: String

    init?(path: String) {
        self.path = path
        guard let file = fopen(path, "r") else {
            return nil
        }
        self.file = file
    }
    deinit {
        fclose(file)
    }

    var nextLine: String? {
        var line: UnsafeMutablePointer<CChar>?
        var linecap = 0
        defer {
            free(line)
        }
        let status = getline(&line, &linecap, file)
        guard status > 0, let unwrappedLine = line else {
            return nil
        }
        return String(cString: unwrappedLine)
    }

    private let file: UnsafeMutablePointer<FILE>
}

extension LineReader: Sequence {
    func makeIterator() -> AnyIterator<String> {
        return AnyIterator<String> {
            return self.nextLine
        }
    }
}
