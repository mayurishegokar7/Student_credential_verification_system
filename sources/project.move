module StudentCredentialVerificationSystem::StudentVerification {
    use std::string::String;
    use aptos_framework::signer;
    use aptos_framework::timestamp;

    // Error codes
    const ENOT_AUTHORIZED: u64 = 1;
    const ECREDENTIAL_NOT_FOUND: u64 = 2;

    /// Structure to store student credentials
    struct Credential has store, key {
        student_name: String,
        course_name: String,
        issue_date: u64,
        is_verified: bool
    }

    /// Function to issue a new credential
    public fun issue_credential(
        issuer: &signer,
        student_name: String,
        course_name: String
    ) {
        let credential = Credential {
            student_name,
            course_name,
            issue_date: timestamp::now_seconds(),
            is_verified: false
        };
        move_to(issuer, credential);
    }

    /// Function to verify a student's credential
    public fun verify_credential(
        verifier: &signer,
        student_address: address
    ): bool acquires Credential {
        let credential = borrow_global_mut<Credential>(student_address);
        credential.is_verified = true;
        credential.is_verified
    }
}