let elfGroups = day1data.split(separator: "\n\n")
let elfTotals = elfGroups.compactMap { group -> Int? in
    let numberStrings = group.split(separator: "\n")
    guard !numberStrings.isEmpty else {
        return nil
    }
    let numbers = numberStrings.compactMap { Int(String($0)) }
    return numbers.reduce(0, +)

}.sorted().reversed()

let topThree = elfTotals.prefix(3).reduce(0, +)
