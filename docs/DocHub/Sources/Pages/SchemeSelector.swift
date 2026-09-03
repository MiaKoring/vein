import Raptor

struct SchemeSelector: HTML {
    var body: some HTML {
        HStack {
            Spacer()
            SegmentedControl {
                Button(
                    action: .switchColorScheme(.dark)
                ) {
                    Image(systemName: "circle")
                }
                .defaultSelection()
                Button(
                    action: .switchColorScheme(.light)
                ) {
                    Image(systemName: "circle-fill")
                }
                Button(
                    action: .switchColorScheme(.automatic)
                ) {
                    Image(systemName: "circle-half")
                }
            }
            .selectionPersisted()
        }
        .padding(.top, .small)
    }
}
