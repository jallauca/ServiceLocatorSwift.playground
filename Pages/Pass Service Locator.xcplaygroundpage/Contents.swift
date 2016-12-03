//: [Previous](@previous)
import XCTest

/*:
 Pass the Service Locator
 Pass the Service Locator as the first parameter to all registered types. Your classes may or may not have dependencies, but if they do, use the Service Locator to resolve them.
 */
protocol Logger {
    func log(_ s: String)
}

class MemoryLogger: Logger {
    var memory = [String]()
    func log(_ s: String) {
        memory = memory + [s]
    }
}

class OutputLogger: Logger {
    func log(_ s: String) {
        print(s)
    }
}

class Apartment {
    let pet: Dog
    let logger: Logger?

    init(_ container: Container) {
        pet = container.resolve()!
        logger = container.resolve()
    }

    func ringDoorbell() {
        logger?.log(pet.makeNoise())
    }
}

//: Let’s register OutputLogger and Apartment
let container = Container()
container.register(SmallDog() as Dog)
container.register(OutputLogger() as Logger)
container.register(Apartment(container))

/*:
 When we resolve an `Apartment`, it will construct a new instance, which in turn will resolve instances of `Dog` and `Logger`. If any of these two inner dependencies, in turn, has its own dependencies, it will request `Container` to resolve them, which becomes a recursive exercise. In the end, an `Apartment` instance triggers recursive calls in `Container` that generates the required dependency tree.
 */
let apartment1: Apartment = container.resolve()!
XCTAssertNotNil(apartment1.pet)
XCTAssertNotNil(apartment1.logger)
apartment1.ringDoorbell()
// "Wow-wow-wow-wow!"

/*:
 With the `OutputLogger`, we cannot make unit tests to verify the proper output, so we will use instead the `MemoryLogger` to write a unit test to verify the proper output message.
 */
container.registerSingleton(MemoryLogger() as Logger)

let memoryLogger: MemoryLogger = container.resolve()! as Logger as! MemoryLogger

let apartment2: Apartment = container.resolve()!
apartment2.ringDoorbell()

XCTAssertEqual("Wow-wow-wow-wow!", memoryLogger.memory.last)