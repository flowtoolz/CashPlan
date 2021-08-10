import SwiftyToolz

extension Asset: Identifiable, Comparable, Hashable {
    
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        lhs.properties.value == rhs.properties.value
    }
    
    // TODO: this is rather view model specific ...
    static func < (lhs: Asset, rhs: Asset) -> Bool {
        abs(lhs.properties.value.profitNumericalValue) > abs(rhs.properties.value.profitNumericalValue)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: HashValue { SwiftyToolz.hashValue(self) }
}
