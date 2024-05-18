import SwiftUI

struct CurrencyPicker: View {
    var body: some View {
        Form {
            Section(header: Text(subtitle)) {
                ForEach(Currency.all) { currency in
                    Button {
                        selectedCurrency = currency
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text(currency.name)
                                .foregroundColor(.primary)
                            Text("(\(currency.symbol))")
                                .foregroundColor(.secondary)
                            Spacer()
                            CurrencyView(currency: currency)
                                .foregroundColor(currency.code == selectedCurrency.code ? .accentColor : .grayedOut)
                                .imageScale(.large)
                        }
                    }
                }
            }
        }
        .navigationTitle(title)
    }
    
    @Environment(\.presentationMode) private var presentationMode
    
    let title: String
    let subtitle: String
    @Binding var selectedCurrency: Currency
}
