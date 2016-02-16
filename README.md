# ActorKit Examples

This Xcode project demonstrates the practical implementation of the actor model in a Cocoa application using the library [github.com/tarbrain/ActorKit](https://github.com/tarbrain/ActorKit).

## Example App

The project contains an iOS application which downloads a bunch of photos off the internet using a supervised pool of actors, each downloading one or more images.

One of the actors in the pool will crash and be re-created by the pool's supervisor.

## Dining Philosophers Problem

The project contains a unit test setup which demonstrates the solution of the [Dining Philosophers Problem](https://en.wikipedia.org/wiki/Dining_philosophers_problem).

Five separate philosopher actors are seated around a table actor. The philosophers can think or eat while sharing chopsticks provided by the table.

The philosophers are supervised. They can get sick and barf across the table while keeping the chopsticks still occupied. The philopher's supervisor then will place the sick philosopher back at the table so he can resume eating until he has enough.

The actors will log their activities to the console:

```
TestActorKit[2965:267496] Heraclitus is eating
TestActorKit[2965:267498] Aristotle gets hungry
TestActorKit[2965:267498] Epictetus is eating
TestActorKit[2965:267499] | eating: Heraclitus Epictetus chopsticks: 1 1 1 1 0 |
TestActorKit[2965:267498] Epictetus gets sick
TestActorKit[2965:267498] Epictetus barfs
TestActorKit[2965:267495] Schopenhauer is thinking
TestActorKit[2965:267488] | eating: Heraclitus Epictetus chopsticks: 1 1 1 1 0 |
TestActorKit[2965:267495] Schopenhauer gets hungry
TestActorKit[2965:267495] Popper is thinking
TestActorKit[2965:267499] | eating: Epictetus chopsticks: 0 0 1 1 0 |
TestActorKit[2965:267495] Popper gets hungry
TestActorKit[2965:267496] Heraclitus is thinking
TestActorKit[2965:267495] | eating: Epictetus chopsticks: 0 0 1 1 0 |
TestActorKit[2965:267496] Heraclitus gets hungry
TestActorKit[2965:267496] Aristotle is thinking
TestActorKit[2965:267500] | eating: Epictetus chopsticks: 0 0 1 1 0 |
TestActorKit[2965:267496] Aristotle gets hungry
TestActorKit[2965:267496] Schopenhauer is thinking
TestActorKit[2965:267500] | eating: Epictetus Popper chopsticks: 1 0 1 1 1 |
TestActorKit[2965:267488] Actor 'Epictetus' <0x7fa479c23fa0> did crash with error: Exception in actor operation: org.philosopher.error, 'Epictetus got sick.', at: (
	0   CoreFoundation           0x000000010e267e65 __exceptionPreprocess + 165
	1   libobjc.A.dylib          0x000000010dce0deb objc_exception_throw + 48
	2   TestActorKitTests        0x000000011ba1d6f1 -[Philosopher barf] + 353
	3   TestActorKitTests        0x000000011ba1d57e -[Philosopher eat] + 398
	4   CoreFoundation           0x000000010e1561cc __invoking___ + 140
	5   CoreFoundation           0x000000010e15601e -[NSInvocation invoke] + 286
	6   ActorKit                 0x000000010d7b80c0 -[TBActorOperation main] + 128
	7   Foundation               0x000000010d873f8a -[__NSOperationInternal _start:] + 646
	8   Foundation               0x000000010d873b9b __NSOQSchedule_f + 194
	9   libdispatch.dylib        0x00000001106a14a7 _dispatch_client_callout + 8
	10  libdispatch.dylib        0x000000011068b0e8 _dispatch_queue_drain + 1048
	11  libdispatch.dylib        0x000000011068aaa0 _dispatch_queue_invoke + 595
	12  libdispatch.dylib        0x000000011068c3b8 _dispatch_root_queue_drain + 565
	13  libdispatch.dylib        0x000000011068c17c _dispatch_worker_thread3 + 98
	14  libsystem_pthread.dylib  0x00000001109d468f _pthread_wqthread + 1129
	15  libsystem_pthread.dylib  0x00000001109d2365 start_wqthread + 13
)
TestActorKit[2965:267496] Schopenhauer gets hungry
TestActorKit[2965:267495] Popper is eating
TestActorKit[2965:267499] | eating: Epictetus Popper chopsticks: 1 0 1 1 1 |
TestActorKit[2965:267495] Popper burps
TestActorKit[2965:267500] Heraclitus is thinking
TestActorKit[2965:267498] | eating: Epictetus Popper chopsticks: 1 0 1 1 1 |
TestActorKit[2965:267500] Heraclitus gets hungry
TestActorKit[2965:267500] Aristotle is thinking
TestActorKit[2965:267495] | eating: Epictetus Popper chopsticks: 1 0 1 1 1 |
TestActorKit[2965:267500] Aristotle gets hungry
TestActorKit[2965:267498] Schopenhauer is thinking
TestActorKit[2965:267500] Epictetus is well again
TestActorKit[2965:267498] Schopenhauer gets hungry
TestActorKit[2965:267495] Epictetus is eating
TestActorKit[2965:267499] | eating: Epictetus chopsticks: 0 0 1 1 0 |
TestActorKit[2965:267495] Epictetus burps
TestActorKit[2965:267500] Popper is thinking
TestActorKit[2965:267496] | eating: Epictetus Heraclitus chopsticks: 1 1 1 1 0 |
TestActorKit[2965:267500] Schopenhauer gets hungry
TestActorKit[2965:267495] Epictetus is thinking
TestActorKit[2965:267496] | eating: Heraclitus chopsticks: 1 1 0 0 0 |
```

## Author

Julian Krumow, julian.krumow@tarbrain.com