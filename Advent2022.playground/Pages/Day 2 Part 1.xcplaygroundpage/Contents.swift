enum Move: String, Equatable {
    case rock
    case paper
    case scissors

    var score: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }

    func outcome(against: Move) -> Outcome {
        if self == against {
            return .draw
        }
        switch (self, against) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            return .win
        default:
            return .lose
        }
    }

    static func fromLetter(letter: String) -> Move? {
        switch letter.lowercased() {
        case "a", "x":
            return .rock
        case "b", "y":
            return .paper
        case "c", "z":
            return .scissors
        default:
            return nil
        }
    }
}

enum Outcome: String {
    case lose
    case draw
    case win

    var score: Int {
        switch self {
        case .lose: return 0
        case .draw: return 3
        case .win: return 6
        }
    }
}

let strat = """
A Y
B X
C Z
"""

func calculateStategy(input: String) -> Int {
    let games = input.split(separator: "\n")
    var total = 0
    for game in games {
        let moves = game.split(separator: " ")
        guard
            moves.count == 2,
            let opponentMove = Move.fromLetter(letter: String(moves[0])),
            let myMove = Move.fromLetter(letter: String(moves[1]))
        else {
            print("Invalid game: \(game)")
            continue
        }
        let outcome = myMove.outcome(against: opponentMove)
//        print("\(opponentMove) vs \(myMove): \(outcome)")
//        print("score of \(outcome.score + myMove.score)")
        total += outcome.score + myMove.score
    }
    return total
}

calculateStategy(input: day2data)
