//: Playground - noun: a place where people can play

protocol Human: CustomStringConvertible{
    var ethnicity: String { get }
    var canRun: Bool { get }
}

extension CustomStringConvertible where Self: Human {
    var description: String {
        return canRun ? "I can run" : "I am lazy"
    }
}

extension Human {
    var canRun: Bool { return self is Runnable }
}

protocol Runnable {
    var runVelocity: Double { get }
}

struct Asian: Human, Runnable {
    let ethnicity = "Asian"
    var runVelocity: Double {
        return 20.0
    }
}

struct Australian: Human, Runnable {
    let ethnicity = "Australian"
    var runVelocity: Double {
        return 40.0
    }
}

struct European: Human {
    let ethnicity = "Australian"
    let canRun = false
}

enum American: Human, Runnable {
    case african
    case european
    case unknown
    
    var ethnicity: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var runVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}

extension American {
    var canRun: Bool {
        return self != .unknown
    }
}

protocol Racable {
    var velocity: Double { get }
}

extension Asian: Racable {
    var velocity: Double {
        return runVelocity
    }
}
extension Australian: Racable {
    var velocity: Double {
        return runVelocity
    }
}
extension European: Racable {
    var velocity: Double {
        return 5
    }
}

extension American: Racable {
    var velocity: Double {
        return canRun ? runVelocity : 0
    }
    
}

class Robot {
    init(name: String) {
        self.name = name
        velocity = 200
    }
    var name: String
    var velocity: Double
}

extension Robot: Racable {}

let racers: [Racable] = [American.african,
                         American.european,
                         American.unknown,
                         Asian(),
                         Australian(),
                         European(),
                         Robot(name: "Giacomo")
                        ]
func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double  where RacerType.Iterator.Element == Racable{
    return racers.max(by: { $0.velocity < $1.velocity })?.velocity ?? 0
}

extension Sequence where Iterator.Element == Racable {
    func topSpeed() -> Double {
        return self.max(by: { $0.velocity < $1.velocity })?.velocity ?? 0
    }
}

topSpeed(of: racers)

topSpeed(of: racers[0...4])

racers[2...6].topSpeed()


topSpeed(of: racers)
let hy = Asian()
let kl = Australian()
let sk = European()
let ds = American.unknown
let dd = American.african
print(ds.description)
print(dd.description)

let numbers = [10,20,30,40,50,60]
let slice = numbers[1...3]// This special wrapper type acts as a view into the original array and avoids costly memory allocations that can quickly add up
let reversedSlice = slice.reversed()//ReversedRandomAccessCollection<ArraySlice<Int>> which is again just a wrapper type view into the original array

let answer = reversedSlice.map { $0 * 10 }// Sequence
print(answer)





