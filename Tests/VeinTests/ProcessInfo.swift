import Foundation

extension ProcessInfo {
    static var shouldEnableEncryption: Bool {
        ProcessInfo.processInfo.environment["SHOULD_DISABLE_ENCRYPTION"] != "1"
    }
}
