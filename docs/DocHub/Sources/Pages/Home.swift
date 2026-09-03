import Foundation
import Raptor

struct Home: Page {
    var title = "Document Hub"
    @Environment(\.themes) var themes
    
    var body: some HTML {
        Include("sitecss.html")
        SchemeSelector()
        HeroSection()
        
        VStack(alignment: .center) {
            Text("Supported platforms:")
                .font(.title5)
                .fontWeight(.medium)
            HStack {
                Image(systemName: "apple")
                Image(systemName: "phone")
                Image(systemName: "laptop")
                Image(systemName: "tv")
                Image(systemName: "headset-vr")
                Image(systemName: "android2")
                Image(systemName: "tux")
                Image(systemName: "windows")
            }
            .font(.title1)
        }
        .foregroundStyle(.secondary)
        .padding(.top, 90)
        
        SubSection1()
            .padding(.top, 40)
    }
}

struct HeroSection: HTML {
    var body: some HTML {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                HStack(spacing: 0) {
                    Image("/images/vein-logo.svg", description: "Amethyst Vein Logo")
                        .resizable()
                        .logoWidth()
                    
                    Text("Vein")
                        .font(.xxLarge)
                        .fontWeight(.medium)
                }
                Spacer(size: .large)
                Text("Write once. Persist anywhere.")
                    .font(.xxxLarge)
                    .fontWeight(.medium)
                    .style(.width(.dvw(100)))
                    .style(.backgroundImage("linear-gradient(0deg, var(--bg-page) 0%, color-mix(in srgb, #DE69FF 50%, transparent) 50%, var(--bg-page) 100%)"))
                
                Text("Vein provides a safe, declarative and elegant foundation to handle data persistance for your Swift apps on any major platform.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .fontWeight(.regular)
                    .frame(maxWidth: 700)
                
                Spacer(size: .medium)
                
                HStack {
                    Link("Get Started", destination: "#getting-started")
                        .primaryButton()
                    StarButton(owner: "amethystsoft", repo: "vein")
                }
            }
            .padding(.vertical, .xLarge)
            
            ScrollView(.horizontal, id: "sample-code") {
                CodeBlock(.swift) { Resources.firstExampleCode }
                    .lineNumberVisibility(.hidden)
                    .multilineTextAlignment(.leading)
                    .style(.custom("mask-image", value: "linear-gradient(to bottom, black 80%, transparent 100%)"))
                    .style(.custom("-webkit-mask-image", value: "linear-gradient(to bottom, black 80%, transparent 100%)"))
                    .cornerRadius(15)
            }
            .frame(maxWidth: 780)
        }
        .multilineTextAlignment(.center)
    }
}
