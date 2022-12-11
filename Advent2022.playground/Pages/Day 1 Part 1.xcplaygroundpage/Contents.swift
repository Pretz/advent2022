let elfGroups = day1data.split(separator: "\n\n")
var highest = 0
for group in elfGroups {
    let numberStrings = group.split(separator: "\n")
    guard !numberStrings.isEmpty else {
        continue
    }
    let numbers = numberStrings.compactMap { Int(String($0)) }
    highest = max(highest, numbers.reduce(0, +))
}
highest
