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
                            CurrencyView(currency: currency)
                                .foregroundColor(currency.code == selectedCurrency.code ? .accentColor : Color(UIColor.systemGray3))
                                .imageScale(.large)
                        }
                    }
                }
            }
        }
        .navigationTitle(title)
    }
    
    let title: String
    let subtitle: String
    @Binding var selectedCurrency: Currency
    @Binding var isBeingPresented: Bool
}
