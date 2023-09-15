class ToolDemo{
  private var number = 0
}

extension ToolDemo {
  @available(*, renamed: "demo1()")
  func demo1(completion: @escaping (Int, Bool) -> Void) {
    Task {
      let result = await demo1()
      completion(result.0, result.1)
    }
  }
  
  
  func demo1() async -> (Int, Bool) {
    let numberBeforeChange = number
    try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    return (number, isGreater)

  }
}

extension ToolDemo {
  func demo2(completion: @escaping (Int, Bool) -> Void) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      let isGreater = number > numberBeforeChange
      completion(number, isGreater)
    }
  }
}

extension ToolDemo {
  func demo3(completion: @escaping (Int, Bool) -> Void) {
    let numberBeforeChange = number
    //      try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    completion(number, isGreater)
  }
}

extension ToolDemo {
  func demo4(completion: @escaping (Int, Bool) -> ()) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      let isGreater = number > numberBeforeChange
      completion(number, isGreater)
    }
  }
}
