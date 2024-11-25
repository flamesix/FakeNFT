import Foundation

protocol LoggingServiceProtocol {
    func logCriticalError(_ message: String, function: String, file: String, line: Int)
}

final class LoggingService: LoggingServiceProtocol {
    
    static let shared = LoggingService()
    
    func logCriticalError(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        let formattedMessage = "[Critical Error] \(message) - \(function) in \(file):\(line)"
        print(formattedMessage)
        assertionFailure(formattedMessage)
    }
    
    private init() {}
    
}
