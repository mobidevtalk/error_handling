import Foundation

/*:
 enum as Error why?
 */
enum AgeError : String{
    case underaged
    case overaged
}

enum RegistrationError : Error{
    case invalidUserName
    case improperAge(AgeError)
}

func registration(userName: String, age: Int) throws {
    if userName.isEmpty {
        throw RegistrationError.invalidUserName
    }
    
    if age < 18 {
        throw RegistrationError.improperAge(.underaged)
    }else if age > 30{
        throw RegistrationError.improperAge(.overaged)
    }
}

do {
    try registration(userName: "mobidevtalk", age: 0)
} catch RegistrationError.improperAge(let age) {
    age
}

do {
    try registration(userName: "mobidevtalk", age: 90)
} catch RegistrationError.improperAge(let age) {
    age
}

/*:
 throws rethrows
 */

enum ReminderError: Error{
    case invalidParam
}

var divisor = 0

func hundredReminder() throws -> Int{
    if divisor == 0 {
        throw ReminderError.invalidParam
    }
    return 100 % divisor
}

func absReminder(input: Int, reminder: () throws -> Int) rethrows -> Int{
    divisor = input < 0 ? abs(input) : input
    return try reminder()
}

do {
    try absReminder(input: -0, reminder: hundredReminder)
} catch ReminderError.invalidParam {
    "Check ur input"
}

do {
    let result = try absReminder(input: -13, reminder: hundredReminder)
    result
} catch ReminderError.invalidParam {
    "Check ur input"
}

/*:
 Propagation of Error
 */

enum PrintError: Error{
    case InvalidName
    case EmptyName
}

func validate(name: String?) throws{
    guard let name = name else {
        throw PrintError.InvalidName
    }
    
    if name.isEmpty {
        throw PrintError.EmptyName
    }
}

func print(name: String?){
    do {
        try validate(name: name)
        print("Name is: \(name!)")
    } catch PrintError.InvalidName {
        print("Got an Invalid Name")
    } catch PrintError.EmptyName {
        print("Got an Empty Name")
    }catch { "Other error \(error.localizedDescription)" }
}

print(name: "") //Prints: Got an Empty Name
print(name: nil) //Prints: Got an Invalid Name
print(name: "Some Name") //Prints: Name is: Some Name
