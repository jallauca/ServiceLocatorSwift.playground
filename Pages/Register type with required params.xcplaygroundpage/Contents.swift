//: [Previous](@previous)
/*: 
 ## Register a Type with Required Parameters
 The `Container` is capable of accepting a constructor method that takes parameters. To resolve a type, we need to provide it the required constructor parameters.
 */
import XCTest

struct WorkerDog: Dog {
    let license: String
    let licenseState: String

    init(license: String, licenseState: String) {
        self.license = license
        self.licenseState = licenseState
    }
    func makeNoise() -> String { return "Woof!" }
}
//: Register `WorkerDog` as `Dog`
let container = Container()
container.register { (number: String, state: String) in
    return WorkerDog(license: number, licenseState: state) as Dog
}

//: Resolve `Dog`
let dog: Dog = container.resolve((license: "YID-233", licenseState: "FL"))!
print(dog.makeNoise())
XCTAssertEqual("Woof!", dog.makeNoise())

/*:
 We could leverage the compiler to help us by providing a tuple initializer `DogInitializer` when we need to `resolve` a `Dog` that has required arguments.
*/
typealias DogInitializer = (license: String, licenseState: String)
struct WorkerDog2: Dog {
    let license: String
    let licenseState: String

    init(_ dogInitializer: DogInitializer) {
        self.license = dogInitializer.license
        self.licenseState = dogInitializer.licenseState
    }
    func makeNoise() -> String { return "Woof!" }
}

//: Register `WorkerDog` as `Dog`
container.register { (number: String, state: String) in
    return WorkerDog2(DogInitializer(license: number, licenseState: state)) as Dog
}

//: Resolve `Dog` with tuple
let dog2: Dog = container.resolve(DogInitializer(license: "YID-233", licenseState: "FL"))!
print(dog2.makeNoise())
XCTAssertEqual("Woof!", dog2.makeNoise())

//: [Next](@next)
