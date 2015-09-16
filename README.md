# Async
Syntactic sugar in Objective-C for asynchronous dispatches in Grand Central Dispatch

#Async
---
Syntactic sugar in Objective-C for asynchronous dispatches in Grand Central Dispatch([GCD](https://developer.apple.com/library/prerelease/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html))

>Note:Here is the [Async](https://github.com/duemunk/Async) in Swift.

**Async** sugar looks like this:<br>
```objective-c
[[Async main:^{								
        NSLog(@"===>>> This is run on the main queue");
}] background:^{
        NSLog(@"===>>> This is run on the background queue");
    }];
```
Instead of the familiar syntax for GCD:
```objective-c
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
    NSLog(@"===>>> This is run on the background queue");
    
	dispatch_async(dispatch_get_main_queue(), {
        NSLog(@"===>>> This is run on the main queue, after the previous block");
	})
})
```

### Benefits
1. Less verbose code
2. Less code indentation

### Things you can do
Supports the modern queue classes:
```objective-c
[GCD mainQueue]
[GCD userInteractiveQueue]
[GCD userInitiatedQueue]
[GCD utilityQueue]
[GCD backgroundQueue]
```

Chain as many blocks as you want:
```objective-c
[[[[[Async main:^{
    // 1
}] background:^{
    // 2
}] utility:^{
    // 3
}] userInteractive:^{
   // 4
}] main:^{
   // 5
}];
```

Store reference for later chaining:
```objective-c
Async *backgroundBlock = [Async background:^{
    NSLog(@"===>>> This is run on the background queue");
}];

// Run other code here...

// Chain to reference
[backgroundBlock main:^{
       NSLog(@"===>>> This is run on the %@, after the previous block", [NSThread currentThread]);
}];
```
