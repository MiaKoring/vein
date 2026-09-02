import Raptor

struct HiddenOnMobile: Style {
    func style(content: Content, environment: Raptor.EnvironmentConditions) -> Content {
        if environment.horizontalSizeClass == .compact {
            content.hidden()
        } else {
            content
        }
    }
}

extension HTML {
    func hiddenOnMobile() -> some HTML {
        style(HiddenOnMobile())
    }
}

enum Font: String {
    case xxLarge = "font2XL"
    case xxxLarge = "font3XL"
}

extension HTML {
    func font(_ font: Font) -> some HTML {
        self
            .class(font.rawValue)
            .class("md:\(font.rawValue)")
    }
}

extension Image {
    func logoWidth() -> some InlineContent {
        self
            .class("logoWidth")
            .class("md:logoWidth")
    }
}
