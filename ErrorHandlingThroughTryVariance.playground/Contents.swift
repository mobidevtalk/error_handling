import Foundation

/*:
 throw rethrow
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
