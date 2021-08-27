import Foundation

func integer(from string: String) -> Int? {
    string.isEmpty ? 0 : Int(string)
}

func double(from string: String) -> Double? {
    string.isEmpty ? 0.0 : Double(string.replacingOccurrences(of: ",", with: "."))
}

extension Double {
    func decimalString(fractionDigits: Int = 2,
                       separator: String = "'") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = separator
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = fractionDigits
        
        let number = NSNumber(floatLiteral: self)
        return formatter.string(from: number) ?? String(format: "%.\(fractionDigits)f", self)
    }
}
