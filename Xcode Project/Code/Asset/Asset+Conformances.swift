import SwiftyToolz

extension Asset: Identifiable, Comparable, Hashable {
    
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        lhs.properties == rhs.properties
    }
    
    // TODO: this is rather view model specific ...
    static func < (lhs: Asset, rhs: Asset) -> Bool {
        lhs.properties.balance.in(.usDollar).numericalValue > rhs.properties.balance.in(.usDollar).numericalValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: HashValue { SwiftyToolz.hashValue(self) }
}
