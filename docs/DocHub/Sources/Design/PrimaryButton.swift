import Raptor

extension InlineContent {
    func primaryButton() -> some InlineContent {
        return self
            .class("primary-button")
    }
}
