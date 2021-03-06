import Foundation

enum RemoteStorageKey: String, CaseIterable {
  case homeListPriority = "home_list_priority"
  case messageCenterStyle = "message_center_style"
  case homeScreenType = "home_screen_type"
  case pendingEvents = "pending_events"
}

enum RemoteStorageType {
  case standard
  case suite
}

struct RemoteStorage {
  private var storageType: RemoteStorageType = .standard
  
  init(storageType: RemoteStorageType = .standard) {
    self.storageType = storageType
  }
  
  func store(_ value: Any, forKey key: RemoteStorageKey) {
    defaults.set(value, forKey: key.rawValue)
  }
  
  func retrieve(forKey key: RemoteStorageKey) -> Any? {
    return defaults.object(forKey: key.rawValue)
  }
  
  func removeObject(forKey key: RemoteStorageKey) {
    defaults.removeObject(forKey: key.rawValue)
  }
  
  func resetStorageKeys() {
    for key in RemoteStorageKey.allCases {
      defaults.removeObject(forKey: key.rawValue)
    }
  }
}

// MARK: Private
private extension RemoteStorage {
  var defaults: UserDefaults {
    switch storageType {
    case .standard:
      return .standard
    case .suite:
      return UserDefaults(suiteName: "group.com.braze.book-demo")!
    }
  }
}
