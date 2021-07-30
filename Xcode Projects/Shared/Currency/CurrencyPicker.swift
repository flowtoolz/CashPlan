import SwiftUI

struct CurrencyPicker: View {
    var body: some View {
        Form {
            Section(header: Text(subtitle)) {
                ForEach(Currency.all) { currency in
                    Button {
                        selectedCurrency = currency
                        isBeingPresented = false
                    } label: {
                        HStack {
                            
                            Text(currency.name)
                                .foregroundColor(.primary)
                            Text("(\(currency.symbol))")
                                .foregroundColor(.secondary)
                            Spacer()
                            Image(systemName: currency.symbolName) // + (currency == selectedCurrency ? ".fill" : ""))
                                .foregroundColor(currency == selectedCurrency ? .accentColor : .secondary)
                                .imageScale(.large)
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Currency")
    }
    
    let subtitle: String
    @Binding var selectedCurrency: Currency
    @Binding var isBeingPresented: Bool
}
