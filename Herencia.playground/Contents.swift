import UIKit

class Vehicle {
    var tires = 4
    var make: String?
    var model: String?
    var currentSpeed: Double = 0
    
    init() {
        print("Llamando al padre")
    }
    func drive(speedIncreanse: Double) {
        print("papa otra vez")
        currentSpeed = speedIncreanse * 2
    }
    func brake() {
        
    }
}

class SportCar: Vehicle {
    override init() {
        super.init()
        print("Llamando al hijo")
        make = "BMW"
        model = "3 Series"
    }
    override func drive(speedIncreanse: Double) {
        print("hijo otra vez")
        currentSpeed += speedIncreanse * 3
    }
}

let car = SportCar()
car.drive(speedIncreanse: 2.0)
print(car.currentSpeed)
