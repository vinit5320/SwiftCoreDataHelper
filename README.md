SwiftCoreDataHelper
===================

Updated with iOS 10 and Swift 3.0 compatibility.

Note: REPLACE THE NSManagedObject ** ATTEND ** WITH YOUR NSManagedObject USED AS ENTITY IN YOUR Coredata MODEL IN THIS FILE.

Helper class for Core Data handling in Swift

Examples
===================

Saving a Core Data entry:

    CoreDataHelper.save("Users", dictionary: [
        "email": "a@alk.im",
        "firstName": "Austin",
        "lastName": "Kelleher"
    ])

Retrieving the first Core Data entry:

    if let user = CoreDataHelper.getFirstCoreDataResult("Users") {
      var email = user.valueForKey("email") as String
      var firstName = user.valueForKey("firstName") as String
      var lastName = user.valueForKey("lastName") as String
    }

Retrieving a specific Core Data entry by Id:

    if let user = CoreDataHelper.getCoreDataResultById("Users", id: 5) {
      var email = user.valueForKey("email") as String
      var firstName = user.valueForKey("firstName") as String
      var lastName = user.valueForKey("lastName") as String
    }
