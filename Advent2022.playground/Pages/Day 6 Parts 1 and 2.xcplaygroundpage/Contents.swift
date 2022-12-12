let seqLength = 14 // set to 4 for part 1
func startOfPacketIndex(input: String) -> Int {
    for startIndex in input.indices.lazy.prefix(input.count - seqLength) {
        let endIndex = input.index(startIndex, offsetBy: seqLength)
        let letterSet = Set(input[startIndex..<endIndex])
        if letterSet.count == seqLength {
            return input.distance(from: input.startIndex, to: endIndex)
        }
    }
    print("no packet found in \(input)")
    return 0
}
startOfPacketIndex(input: day6data)
