let pairs = day4data.split(separator: "\n")
let rangePairs = pairs
    .map { $0.split(separator: ",")
            .map({ $0.split(separator: "-")
                    .compactMap({ Int($0) })
            })
            .map({ pairArray in
                pairArray[0]...pairArray[1]
            })
    }

let overlapCount = rangePairs
    .map { pairs in pairs[0].overlaps(pairs[1]) ? 1 : 0 }
    .reduce(0, +)
