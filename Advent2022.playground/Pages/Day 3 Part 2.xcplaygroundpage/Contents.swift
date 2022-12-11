func priority(of char: Character) -> Int {
    guard char.isASCII else { return 0 }
    let lowerAValue = Int(Character("a").asciiValue!)
    let upperAValue = Int(Character("A").asciiValue!)
    let asciiValue = Int(char.asciiValue!)
    if asciiValue >= lowerAValue {
        return asciiValue - lowerAValue + 1
    } else {
        return asciiValue - upperAValue + 27
    }
}

let packs = day3data.split(separator: "\n")
var overlaps = [Character]()
for groupIndex in stride(from: 0, to: packs.count, by: 3) {
    guard
        let overlap = Set(packs[groupIndex])
            .intersection(Set(packs[groupIndex + 1]))
            .intersection(Set(packs[groupIndex + 2]))
            .first
    else {
        print("No overlap found for \(packs[groupIndex...groupIndex + 2])")
        continue
    }
    overlaps.append(overlap)
}

let count = overlaps
    .map(priority)
    .reduce(0, +)
