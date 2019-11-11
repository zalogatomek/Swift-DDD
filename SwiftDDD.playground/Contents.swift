import Foundation

// Typical Contact Model

struct ContactTypical {
    let firstName: String
    let middleInitial: String?
    let lastName: String
    let emailAddress: String
    let isEmailVerified: Bool
}

// Step 1 - Wrap primitive types

struct Name: CustomStringConvertible {
    private static let maxLength: Int = 50
    let value: String
    
    init?(string: String?) {
        guard let string = string, string.count < Name.maxLength else { return nil }
        value = string
    }
    
    var description: String {
        return value
    }
}

struct Initial {
    private static let lenght: Int = 1
    let value: String
    
    init?(string: String?) {
        guard let string = string, string.count == Initial.lenght else { return nil }
        value = string
    }
    
    var description: String {
        return value
    }
}

struct Email: CustomStringConvertible {
    private static let emailRegex = "[^@]+@[^\\.]+\\..+"
    let value: String
    
    init?(string: String?) {
        guard let email = string, Email.isValidEmail(email: email) else { return nil }
        self.value = email
    }
    
    private static func isValidEmail(email: String) -> Bool {
        return email.range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var description: String {
        return value
    }
}

struct ContactWrappedTypes {
    let firstName: Name
    let middleInitial: Initial?
    let lastName: Name
    let emailAddress: Email
    let isEmailVerified: Bool
}

// Step 2 - Group Linked Data

struct PersonalName {
    let firstName: Name
    let middleInitial: Initial?
    let lastName: Name
}

struct EmailContactInfo {
    let emailAddress: Email
    let isEmailVerified: Bool
}

struct ContactLinkedData {
    let name: PersonalName
    let email: EmailContactInfo
}

// Step 3 - Encoding domain logic
// Rule 1: If email has changed, verify needs to be set to false
// Rule 2: The verify flag can be only set by a verification service

protocol VerificationService {
    typealias VerificationHash = String // Not important for playground
    func verify(email: Email, hash: VerificationHash) -> VerifiedEmail
}

struct VerifiedEmail {
    let value: String
    
    init(email: Email) { // accessible only for VerificationService
        self.value = email.value
    }
}

enum EmailInfo {
    case verfied(Email)
    case unverified(Email)
}

struct Contact {
    let name: PersonalName
    let email: EmailInfo
}

// Extra1 - Making illegal states imposible
// Add Postal Address, following bussiness rule: A contact must have email or postalAddress

struct PostalAddress {
    // Not important for playground
}

enum ContactInfoExtra1 {
    case email(Email)
    case postalAddress(PostalAddress)
    case emailAndPostalAddress(Email, PostalAddress)
}

struct ContactExtra1 {
    let name: PersonalName
    let contactInfo: ContactInfoExtra1
}

// Extra2 - Making illegal states imposible
// Add Postal Address, following bussiness rule: A contact must have at least one way of being contacted

enum ContactInfo {
    case email(Email)
    case postalAddress(PostalAddress)
}

struct ContactExtra2 {
    let name: PersonalName
    let primaryContactInfo: ContactInfo
    let secondaryContactInfo: ContactInfo?
}
