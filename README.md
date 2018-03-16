# eCVI
eCVI Data Exchange Standard (Starting with version 2)

This project is the home of the AAVLD/USAHA Data Standards Committee's work on the eCVI Data Exchange standard starting with version 2.  See: https://github.com/tracefirst/usaha_committee for version 1

A few words on the documentation approach: 
 
If the code only defines something once (i.e. for reusable complex elements), the documentation also only describes the details once, wherever it is defined. Where elements are referred to but not defined, the documentation similarly refers to that element without specifying further details (i.e. "see PersonType") If the code does have some duplication (i.e. pattern matching for Age in Animal and Age in GroupLot), the documentation is also duplicated. If the code is effectively the same in those different places, the wording in the documentation is also kept the same. This allows the documentation to stay consistent with any potential code changes, in case it should change in one location but not another.
    
The exception to this is where it may be misleading to omit some of the details - this so far only applies to the description of the high-level CVI elements, where the code specifies something is required but in practice it can have a count of zero.
