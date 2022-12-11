func findOverlaps(input: some StringProtocol) -> Set<Character> {
    let midPoint = input.index(input.startIndex, offsetBy: input.count / 2)
    let firstHalfSet = Set(input[..<midPoint])
    var overlaps: Set<Character> = []
    for char in input[midPoint...] {
        if firstHalfSet.contains(char) {
            overlaps.insert(char)
        }
    }
    return overlaps
}

func priority(of char: Character) -> Int {
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
let overlaps = packs.map(findOverlaps).flatMap(Array.init)
let count = overlaps.reduce(0) { total, character in
    if character.isASCII {
        return priority(of: character) + total
    }
    return total
}
