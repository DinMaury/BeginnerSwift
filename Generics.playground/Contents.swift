import UIKit

func intAdder(number: Int) -> Int {
    
    return number + 1
}

intAdder(number: 15)

func doubleAdder(number: Double) -> Double {
    
    return number + 1.0
}

doubleAdder(number: 15)

func genericAdder<T: Numeric>(number: T) -> T {
    return number + 1
}

genericAdder(number: 15)
