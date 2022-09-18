#  Heartbeat

Example implementation:

```
let stockA = Stock(current: 100, ideal: 100, minimum: 0, maximum: 100)
let stockB = Stock(current: 0, ideal: 100, minimum: 0, maximum: 100)
let flow = Flow(from: stockA, to: stockB, amount: 1)
let system = System(stocks: [stockA, stockB], flows: [flow])
let world = World(
    system: system,
    iterations: 0)

var app = App(
    state: world,
    input: World.input,
    update: World.update,
    display: World.display,
    shouldExit: World.shouldExit)

app.run()

RunLoop.current.run()
```
