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
