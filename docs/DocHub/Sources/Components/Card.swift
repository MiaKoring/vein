import Raptor

struct Card: HTML {
    let image: ImageKind
    let title: String
    let description: String
    let link: String
    
    var body: some HTML {
        VStack(alignment: .leading) {
            switch image {
                case .system(let systemImage):
                    Image(systemName: systemImage)
                        .font(.title1)
                        .foregroundStyle(.accent)
                case .other(let imagePath):
                    Image(imagePath)
                        .resizable()
                        .style(.width(.em(3.3)))
                        .foregroundStyle(.accent)
            }
            
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)
            LinkGroup(destination: link) {
                HStack(spacing: 5) {
                    Text("Learn more")
                    Image(systemName: "chevron-right")
                }
                .font(.title5)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
            }
        }
        .padding(40)
        .cornerRadius(20)
        .background(.accent.opacity(0.1))
    }
    
    enum ImageKind {
        case system(String)
        case other(String)
    }
}
