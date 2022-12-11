let pairs = day4data.split(separator: "\n")
let rangePairs = pairs
    .map { $0.split(separator: ",")
            .map({ $0.split(separator: "-")
                    .compactMap({ Int($0) })
            })
            .map({ pairArray in
                Set(pairArray[0]...pairArray[1])
            })
    }

rangePairs.map { pairs in
    if pairs[0].isSubset(of: pairs[1]) || pairs[1].isSubset(of: pairs[0]) {
        return 1
    }
    return 0
}
.reduce(0, +)
