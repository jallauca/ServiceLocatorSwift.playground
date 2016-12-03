//: [Previous](@previous)
/*:
 ## Resolve new objects every time
 Let’s verify that every time that we resolve a type, we get a new object. 
 */
import UIKit
import XCTest

class RedUIViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.red
    }
}

let container = Container()
container.register(RedUIViewController() as UIViewController)

//: We illustrate two of ways to `resolve` an object
let viewController1: UIViewController = container.resolve()!
let viewController2 = container.resolve()! as UIViewController

//: Then we verify two different `RedUIViewController` objects were created
XCTAssertEqual(UIColor.red, viewController1.view.backgroundColor)
XCTAssertEqual(UIColor.red, viewController2.view.backgroundColor)
XCTAssertNotEqual(viewController1, viewController2)
XCTAssertFalse(viewController1 === viewController2)

//: [Next](@next)
