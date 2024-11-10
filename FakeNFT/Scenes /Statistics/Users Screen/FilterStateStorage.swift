import Foundation

final class FilterStateStorage {
    static let shared = FilterStateStorage()
    
    private let userDefaults = UserDefaults.standard
    
    var filterOption: FilterOption? {
        get {
            if let filterDescription = userDefaults.string(forKey: "filterOption") {
                return FilterOption(rawValue: filterDescription)
            }
            return nil
        }
        set {
            userDefaults.set(newValue?.rawValue, forKey: "filterOption")
        }
    }
    
    private init() {}
}
