import Foundation

struct EmailResponse: Codable{
    let address: String?
    let verified: Bool
    let verificationCodeSent: Bool
    
    enum CodingKeys: String, CodingKey{
        case address
        case verified = "_verified"
        case verificationCodeSent = "_verification_code_sent"
    }
}

struct StudentDataResponse: Codable {
    let lastName: String?
    let socialAccounts: [String?]
    let mailingAddress: Bool?
    let cohortKeys: [String?]
    let signature: String?
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
    var location: String?
    let externalServicePassword: String?
    let principals: [String?]
    let enrollements: [String?]
    let email: EmailResponse
    var websiteURL: String?
    let externalAccounts: [String?]
    let bio: String?
    let coachingData: String?
    let tags: [String?]
    let affliateProfiles: [String?]
    let hasPassword: Bool
    let emailPreferences: String?
    let resume: String?
    let key: String?
    let nickname: String?
    let employerSharing: Bool
    let memberships: [String?]
    let zendeskID: String?
    let registered: Bool
    var linkedinUrl: String?
    let googleID: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey{
        case lastName = "last_name"
        case socialAccounts = "social_accounts"
        case mailingAddress = "mailing_address"
        case cohortKeys = "_cohort_keys"
        case signature = "signature"
        case stripeCustomerID = "_stripe_customer_id"
        case guardResponse = "guard"
        case facebookID = "_facebook_id"
        case timezone = "timezone"
        case sitePreferences = "site_preferences"
        case occupation = "occupation"
        case image = "_image"
        case firstName = "first_name"
        case jabberID = "jabber_id"
        case languages = "languages"
        case badges = "_badges"
        case location = "location"
        case externalServicePassword = "external_service_password"
        case principals =  "_principals"
        case enrollements = "_enrollments"
        case email = "email"
        case websiteURL = "website_url"
        case externalAccounts = "external_accounts"
        case bio = "bio"
        case coachingData = "coaching_data"
        case tags = "tags"
        case affliateProfiles = "_affiliate_profiles"
        case hasPassword = "_has_password"
        case emailPreferences = "email_preferences"
        case resume = "_resume"
        case key = "key"
        case nickname = "nickname"
        case employerSharing = "employer_sharing"
        case memberships = "_memberships"
        case zendeskID = "zendesk_id"
        case registered = "_registered"
        case linkedinUrl = "linkedin_url"
        case googleID = "_google_id"
        case imageURL = "_image_url"
    }
}
