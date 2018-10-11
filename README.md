# Sample iOS Application Architecture Code

This is the sample code from talks called MVVM-C in Practice and iOS Architecture Tips & Tricks.

It is a demo application using an MVC / MVVM(esque) architecture with [Coordinators](http://khanlou.com/2015/10/coordinators-redux/)

This is a simple architecture,  with many holes, designed to help people learn how to architect code with a good separation of concerns.
It is not pure MVC or MVVM but takes ideas from each. The implementation of Coordinators borrows heavily from Soroush Khanlou's ideas but also has a number of differences.

This architecture should be used for learning some principles rather than something to just use. For simplicity sake, there are issues that it just ignores that would need to be handled in any app handling large amounts of data or complex user interactions.

![Architecture](readme/architecture.png)