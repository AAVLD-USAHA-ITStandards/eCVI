# eCVI
eCVI Data Exchange Standard (Starting with version 2)

This project is the home of the AAVLD/USAHA Data Standards Committee's work on the eCVI Data Exchange standard starting with version 2.  See: https://github.com/tracefirst/usaha_committee for version 1

Committee Membership https://github.com/AAVLD-USAHA-ITStandards/eCVI/tree/master/Governance/membership.md

A few words on the documentation approach: 
 
First and foremost, the XML schema *is* the standard.  All other material is supplemental documentation, committee governance, etc.  The committee sometimes provides "bridge" schemas that will validate content in either of two versions to help implementers synchronize upgrading.

The documentation in human-readable format is a best effort at converting the structure and documentation elements in the schema.  It is for reference only.  If the documentation differs from the schema structure, the structure rules.  

The **Issues** section of this project contains open issues before the committee.  Some of these are being actively worked, while others are on-hold for a future major release, etc.  Anyone who sees problems or areas to improve the standard is encouraged to create a new Issue.  

The **Releases** section of this project contains the numbered release commits.  Releases are numbered Major.Minor.Editorial.  Implementers should be able to ignore differences between versions that vary only in the third part.

## Relationship to Other Groups

This standard is maintained by a sub-committee of the AAVLD/USAHA Joint Committee on Animal Health Surveillance and Information Systems.  The Data Standards Subcommittee needs both the eCVI industry and Animal Health database industry represented along with state and federal regulators.  The logical parent is AAVLD/USAHA.  This committee determines the best format for exchange of data.  State and Federal officials specify what information they require and the industry representatives negotiate how best to exchange that.

The data standards subcommittee has no compliance or enforcement responsibility.  Approval of data systems including electronic CVIs is a function of each animal health authority.  

In an effort to promote wider adoption of electronic CVIs by simplifying the approval process, the National Assembly of State Animal Health Officials (State Veterinarians) appointed a subcommittee of the Animal Disease Traceability Technology Committee to review eCVIs and recommend approval by all states.  Because this is falls solely under the purview of the State Veterinarians, this subcommittee does not include industry representation.   Technically all this group does is pass on a recommendation to each State Veterinarian that they approve a reviewed product (or not).  ONE OF the criteria used is the data exchange standard XML schema.
