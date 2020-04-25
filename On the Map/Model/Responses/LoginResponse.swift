
import Foundation

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}
struct LoginResponse: Codable, LocalizedError {
    let account: Account
    let session: Session
    var errorDescription: String?{
        return "Invalid credentials"
    }
}
