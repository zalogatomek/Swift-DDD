# Swift-DDD

My interpretaion on [Domain Driven Design by Scott Wlaschin](https://fsharpforfunandprofit.com/ddd/) in Swift.

Simple playground showing DDD aproach to make below code _better_.

```swift
struct Contact {
    let firstName: String
    let middleInitial: String?
    let lastName: String
    let emailAddress: String
    let isEmailVerified: Bool
}
```

Problems with above code? It does not show:
+ ~~Which values are optional?~~ - *Not aplicable to Swift, since there are optional types*
+ What are the constraints? *Is data somehow validated?*
+ Which fields are linked?
+ Is there any domain *(bussiness)* logic there?
