import Foundation

class Employee {
    var firstName = "Swapnil"
    var lastName = "Jain"
    var passion = "Car, Bike"
}

class Organization {
    var employees = [Employee]()
}

func buildHashMap(employees: [Employee]){
    var hashMap: Dictionary<String, Employee> = Dictionary()
    for employee in employees{
        hashMap[employee.firstName] = employee
    }
}

func addEmployee(organization: Organization, employee: Employee){
    organization.employees.append(employee)
}
