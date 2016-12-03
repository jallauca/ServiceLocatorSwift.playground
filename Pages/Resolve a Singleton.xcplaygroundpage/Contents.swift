//: [Previous](@previous)
/*:
 ## Resolve a Singleton
 When we need to restrict the instantiation of the class to one object, we need to register a singleton. The syntax is the same, but we make the proper call.
 */
import UIKit
import XCTest

let container = Container()
container.registerSingleton(RedUIViewController() as UIViewController)

let singletonViewController1: UIViewController = container.resolve()!
let singletonViewController2 = container.resolve()! as UIViewController

XCTAssertEqual(UIColor.red, singletonViewController1.view.backgroundColor)
XCTAssertEqual(UIColor.red, singletonViewController2.view.backgroundColor)
XCTAssertEqual(singletonViewController1, singletonViewController2)
XCTAssertTrue(singletonViewController1 === singletonViewController2)

//: [Next](@next)
