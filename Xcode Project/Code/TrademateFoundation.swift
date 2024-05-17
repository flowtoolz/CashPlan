import Foundation

func integer(from string: String, defaultValue: Int = 0) -> Int {
    (string.isEmpty ? 0 : Int(string)) ?? defaultValue
}

func double(from string: String, defaultValue: Double = 0) -> Double {
    (string.isEmpty ? 0.0 : Double(string.replacingOccurrences(of: ",", with: "."))) ?? defaultValue
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
    
    var displayText: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0 // No minimum fraction digits
        
        if truncatingRemainder(dividingBy: 1) == 0 {
            formatter.maximumFractionDigits = 0 // No digits after decimal if round
        } else {
            formatter.maximumFractionDigits = 1 // One digit after decimal if not round
        }
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
