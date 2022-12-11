let samplePositions = """
    [D]
[N] [C]
[Z] [M] [P]
"""

let sampleMovements = """
move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""

let stackCount = 9 // 9 for realsies

var stacks = [[Character]](repeating: [], count: stackCount)

for stackline in day5Positions.split(separator: "\n") {
    for (crateIndex, cratePosition) in stride(from: 1, to: stackCount * 4, by: 4).enumerated() {
        guard cratePosition < stackline.count else {
            continue
        }
        let crateContents = stackline[stackline.index(stackline.startIndex, offsetBy: cratePosition)]
        if String(crateContents) != " " {
            stacks[crateIndex].append(crateContents)
        }
    }
}

let instructions = day5movements.split(separator: "\n")
    .map { $0.filter { !$0.isLetter } }
    .map { $0.split(separator: " ")
            .compactMap({ Int($0) })
    }

for step in instructions {
    let count = step[0]
    let sourceStack = step[1] - 1
    let destinationStack = step[2] - 1

    stacks[destinationStack].insert(contentsOf: stacks[sourceStack][0..<count].reversed(), at: 0)
    stacks[sourceStack].removeFirst(count)
}

stacks
let output = String(stacks.compactMap({ $0.first }))
output
