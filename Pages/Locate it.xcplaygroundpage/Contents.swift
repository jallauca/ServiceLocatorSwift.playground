//: [Previous](@previous)
/*:
## Locate it!
Let’s use the Service Locator `Container` to locate concrete implementations of our abstractions. We’ll create a very simple example. We need a `Dog` protocol, which is an abstraction and two concrete implementations `SmallDog` and `RobotDog`.
 */
import UIKit
import XCTest

protocol Dog {
    func makeNoise() -> String
}
struct SmallDog: Dog {
    func makeNoise() -> String { return "Wow-wow-wow-wow!" }
}
struct RobotDog: Dog {
    func makeNoise() -> String { return "10-W-o-o-f-01" }
}

/*:
We will create a `Container` to allow us to register our concrete implementations. But, we need to specify what kind of abstraction each registration is providing to us. In this simple example, `SmallDog` is registered as a concrete implementation of `Dog`
 */
let container = Container()
container.register(SmallDog() as Dog)

/*: Resolve `Dog` and make noise */
var dog = container.resolve()! as Dog
print(dog.makeNoise())
XCTAssertEqual("Wow-wow-wow-wow!", dog.makeNoise())

//: [Next](@next)
