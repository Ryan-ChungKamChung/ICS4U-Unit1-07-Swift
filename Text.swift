import Foundation

private var nextNextGaussian: Double? = {
    srand48(Int.random(in: 0...100))
    return nil
}()

func nextGaussian() -> Double {
    if let gaussian = nextNextGaussian {
        nextNextGaussian = nil
        return gaussian
    } else {
        var v1, v2, s: Double

        repeat {
            v1 = 2 * Double.random(in: 0.0...1.0) - 1
            v2 = 2 * Double.random(in: 0.0...1.0) - 1
            s = v1 * v1 + v2 * v2
        } while s >= 1 || s == 0

        let multiplier = sqrt(-2 * log(s)/s)
        nextNextGaussian = v2 * multiplier
        return v1 * multiplier
    }
}

func generateTable(students: [String], assignments: [String]) -> [[String]] {
    let numStudents = students.count
    let numAssignments = assignments.count

    var markArray: [[String]] = []

    for row in 0..<numStudents {
        markArray.append([String]())
        markArray[row].append(students[row])

        for _ in 0..<numAssignments {
            let mark = Int(floor(nextGaussian() * 10 + 75))
            markArray[row].append(String(mark))
        }
    }

    return markArray
}

let students = ["Ryan", "Roman", "Jenoe"]
let assignments = ["#1", "#2", "#3"]

print(generateTable(students: students, assignments: assignments))
