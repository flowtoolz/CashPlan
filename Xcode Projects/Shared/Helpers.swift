func integer(from string: String) -> Int? {
    string.isEmpty ? 0 : Int(string)
}

func double(from string: String) -> Double? {
    string.isEmpty ? 0.0 : Double(string.replacingOccurrences(of: ",", with: "."))
}
