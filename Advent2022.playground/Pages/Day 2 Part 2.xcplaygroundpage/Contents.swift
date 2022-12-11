enum Move: String, Equatable {
    case rock, paper, scissors

    var score: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }

    var beats: Move {
        switch self {
        case .rock: return .scissors
        case .scissors: return .paper
        case .paper: return .rock
        }
    }

    func outcome(against: Move) -> Outcome {
        switch against {
        case self: return .draw
        case self.beats: return .win
        default: return .lose
        }
    }

    static func fromLetter(letter: String) -> Move? {
        switch letter.lowercased() {
        case "a": return .rock
        case "b": return .paper
        case "c": return .scissors
        default: return nil
        }
    }

    func opposingMove(letter: String) -> Move? {
        switch letter.lowercased() {
        case "x": return self.beats
        case "y": return self
        case "z": return self.beats.beats
        default: return nil
        }
    }
}

enum Outcome: String {
    case lose, draw, win

    var score: Int {
        switch self {
        case .lose: return 0
        case .draw: return 3
        case .win: return 6
        }
    }
}

func calculateStategy(input: String) -> Int {
    let games = input.split(separator: "\n")
    var total = 0
    for game in games {
        let moves = game.split(separator: " ").map(String.init)
        guard
            moves.count == 2,
            let opponentMove = Move.fromLetter(letter: moves[0]),
            let myMove = opponentMove.opposingMove(letter: moves[1])
        else {
            print("Invalid game: \(game)")
            continue
        }
        let outcome = myMove.outcome(against: opponentMove)
        total += outcome.score + myMove.score
    }
    return total
}

calculateStategy(input: day2data)
