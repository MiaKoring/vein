import Raptor

struct SponsorButton: HTML {
    var body: some HTML {
        ZStack {
            HStack(spacing: 5) {
                Image(systemName: "suit-heart")
                    .font(.title5)
                    .foregroundStyle(.red.opacity(0.5))
                Link("Sponsor", destination: "https://github.com/sponsors/MiaKoring")
                    .linkOpenBehavior(.newWindow)
                    .foregroundStyle(.secondary)
                    .font(.title5)
            }
            .id("sponsor-button-off")
            
            HStack(spacing: 5) {
                Image(systemName: "suit-heart")
                    .font(.title5)
                    .foregroundStyle(.red)
                Link("Sponsor", destination: "https://github.com/sponsors/MiaKoring")
                    .linkOpenBehavior(.newWindow)
                    .font(.title5)
            }
            .hidden()
            .id("sponsor-button-on")
        }
        .onHover { _ in
            [
                .toggleElementVisibility("sponsor-button-off"),
                .toggleElementVisibility("sponsor-button-on")
            ]
        }
    }
}
