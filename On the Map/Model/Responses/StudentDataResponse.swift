import Foundation

struct EmailResponse: Codable{
    let address: String?
    let verified: Bool
    let verificationCodeSent: Bool
}

struct UserResponse: Codable {
    let lastName: String
    let socialAccounts: [String?]
    let mailingAddress: Bool?
    let cohortKeys: [String?]
    let signature: String
    let stripeCustomerID: Bool?
    let guardResponse: [String:String?]
    let facebookID: String?
    let timezone: String?
    let sitePreferences: String?
    let occupation: String?
    let image: String?
    let firstName: String?
    let jabberID: String?
    let languages: String?
    let badges: [String?]
    let location: String?
    let email: EmailResponse
    let websiteURL: String?
    let externalAccounts: [String?]
    let bio: String?
    let coachingData: String?
    let tags: [String?]
    let affliateProfiles: [String?]
    
}

struct StudentDataResponse: Codable {
    let user: UserResponse
}
