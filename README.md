# iOS-Starter2019

Build : [![Build Status](https://travis-ci.org/3IE/iOS-Starter2019.svg?branch=develop)](https://travis-ci.org/3IE/iOS-Starter2019)


This Starter Kit is a project which we use at 3IE every time we have to begin a new iOS application development.
The main goal of this project is to create an architecture which will be the same for all our projects.
The objective is also to gather some frameworks we always use in order to spare us some time.

The Starter has a few examples to show how to connect the various layers.  

## Architecture

### Targets

The objective is to add some information in different targets. We can for example think of the API root endpoint or different values.
That's why we almost always have 3 main targets:
- Development target
- Pre-production target
- Production target

This allows us to have different plist files to store information but this also allows us to have some resources depending the target we compile.

#### Frameworks

The `Framework` folder is used to add some open source frameworks we found on places like github and that we need to integrate into our projects. To add these projects into our own, we decided to use the git submodule way of doing it since it is the easier and the best from our point of view.
Compile time may be a bit longer the first time since it has to compile the external frameworks we added but we can see what happens if there is an error and we can place the submodule on whichever commit we want.

In this starter kit, we provide several external frameworks that we use in our project and that helps this architecture be what it is.

- <a href="https://github.com/Alamofire/Alamofire">Alamofire</a> is an HTTP networking library written in Swift.
- <a href="https://github.com/Alamofire/AlamofireImage">AlamofireImage</a> is an image component library for Alamofire.
- <a href="https://github.com/Hearst-DD/ObjectMapper">ObjectMapper</a> is a JSON mapping library.
- <a href="https://github.com/jdg/MBProgressHUD">MBProgressHUD</a> is a lightweight progress HUD.

#### Models

The `Models` folder contains the description (classes) of the data we have to manipulate in our application to do the app business.

#### DataAccess

The `DataAccess` folder contains files that will provide some services to our business. For example, calling a webservice is a service. But services are not necessarily webservices calls. Services may be calls to a CoreData database or call to get some data written in the phone memory.

#### Business

The `Business` folder contains files that will call some services and work over the datas returned from these services to have a data that can be served to the controller which was calling that business method.

#### Utils

The `utils` folder is the one that will contains some general classes with helper methods. The main goal is that this folder contain files, classes and methods that can be useful in every project we develop.

#### Controllers

The `Controllers` folder contains all your controllers files (eg. UIViewController, UITableViewController ...). We will not take time to explain what is a controller since everyone reading this should be ware of it.

#### Views

  - Swift

  This `Swift` folder contains some classes describing special behavior for some components. It basically contains subclasses of UIView type (eg. UILabel, UIButton, UIView, UITableView ...). This folder is also handy to store IBDesignables and IBInspectables you create.

  - Xib

  The `Xib` folder is useful for storing some interface builder file. In this starter kit, we use storyboards. But in order to avoid copying some elements, we put some elements that are useful in several views of our application in interface builder files that we store in the `Xib` folder. For instance, cells that could be use in several views will be in a .xib file in this folder.



## Installing the external frameworks

We use Swift Package Manager, so the frameworks are automatically downloaded and compiled on the project by Xcode.

## Documentation

Use the shortcut (⌥ Option + ⌘ Command + /) in Xcode 8 to add documentation to your code.
