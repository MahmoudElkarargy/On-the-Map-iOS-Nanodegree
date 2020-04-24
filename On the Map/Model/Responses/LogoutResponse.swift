
import Foundation

struct SessionID: Codable {
    let id: String
    let expiration: String
}

struct LogoutResponse: Codable {
    let session: SessionID
}
