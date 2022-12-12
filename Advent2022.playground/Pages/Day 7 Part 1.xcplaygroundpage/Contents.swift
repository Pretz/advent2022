struct File {
    let name: String
    let size: Int
}

class Directory {
    let name: String
    var files = [File]()
    var children = [Directory]()
    weak var parent: Directory?

    var _size: Int?

    var size: Int {
        if _size == nil {
            _size = files.map(\.size).reduce(0, +) + children.map(\.size).reduce(0, +)
        }
        return _size!
    }

    init(name: String, parent: Directory?) {
        self.name = name
        self.parent = parent
    }

    @discardableResult func add(directory name: String) -> Directory {
        guard let directory = children.first(where: { $0.name == name }) else {
            let dir = Directory(name: name, parent: self)
            children.append(dir)
            return dir
        }
        return directory
    }

    func add(file name: String, size: Int) {
        guard files.first(where: { $0.name == name }) == nil else {
            return
        }
        files.append(File(name: name, size: size))
    }
}

var root = Directory(name: "/", parent: nil)

func changeDir(currentDir: Directory, destination: String) -> Directory {
    switch destination {
    case "..":
        return currentDir.parent!
    case "/":
        return root
    default:
        return currentDir.add(directory: destination)
    }
}

func parseCommands(commandInput: String) {
    var currentDir = root
    var commands = commandInput.lazy.split(separator: "\n").map { $0.split(separator: " ") }
    while !commands.isEmpty {
        let command = commands.removeFirst().map(String.init)
        switch command[1] {
        case "cd":
            currentDir = changeDir(currentDir: currentDir, destination: command[2])
        case "ls":
            while !commands.isEmpty && String(commands[0][0]) != "$" {
                let next = commands.removeFirst().map(String.init)
                if next[0] == "dir" {
                    currentDir.add(directory: next[1])
                } else {
                    guard let fileSize = Int(next[0]) else {
                        print("invalid directory listing: \(next)")
                        continue
                    }
                    currentDir.add(file: next[1], size: fileSize)
                }
            }
        default:
            print("Unknown command: \(command)")
            continue
        }
    }
}

parseCommands(commandInput: day7data)

func findBelowSize(in directory: Directory) -> [Directory] {
    let bigSize = 100_000

    let base: [Directory]
    if directory.size <= bigSize {
        base = [directory]
    } else {
        base = []
    }
    return base + directory.children.flatMap(findBelowSize(in:))
}

findBelowSize(in: root).map(\.size).reduce(0, +)


extension Directory {
    func printDebug(prefix: String) {
        print(prefix + "- \(name) (dir)")
        for file in files {
            print(prefix + " - \(file.name) (file, size=\(file.size))")
        }
        for dir in children {
            dir.printDebug(prefix: prefix + " ")
        }
    }
}

root.printDebug(prefix: "")
