# LoopImageCarousel

## Features
*  ***Infinite*** scrolling.
*  ***Automatic*** Sliding.

### Configuration

- `perView`: CGFloat - Determines what size the slides should be in relation to the container. Default is 1.
- `interItemSpacing`: CGFloat - The spacing to use between items in the pager view. Default is 0.
- `timeInterval`:Double - The time interval of automatic sliding. 0 means disabling automatic sliding. Default is 0.

**e.g**

```swift
carousel.configuration = Configuration(
    perView = 1.0, 
    interItemSpacing = .zero, 
    timeInterval = 3.0
)
```

## How to use
You can just import `LoopImageCarousel` to use it.

### 1. Getting started

```swift
import LoopImageCarousel

let carousel = LoopImageCarousel()
carousel.dataSource = self
carousel.delegate = self
carousel.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
view.addSubview(carousel)
```

### 2. Implement LoopImageCarouselDataSource

```swift
    func numberOfItems(in loopImageCarousel: LoopImageCarousel) -> Int {
        carouselImages.count
    }
    
    func loopImageCarousel(_ loopImageCarousel: LoopImageCarousel, cellForItemAt index: Int) -> CarouselCollectionViewCell {
        let cell = carousel.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = carouselImages[index].image
        return cell
    }
```

### 3. Implement LoopImageDelegate

---
```swift 
    func loopImageCarousel(_ loopImageCarousel: LoopImageCarousel, didSelectItemAt index: Int)
```
> Tells the delegate that the item at the specified index was selected.
---

```swift
    func loopImageCarousel(_ loopImageCarousel: LoopImageCarousel, currentItemAt index: Int)
```
> Tells the delegate that the specified cell is about to be displayed in the carousel.

## Installation
LoopImageCarousel is available through SPM. To install it, add the package to your dependencies in your `Package.swift` file.

```swift

let package = Package(
    dependencies: [
        .package(url: "https://github.com/Yudai-ASANO/LoopImageCarousel", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "<your-target-name>",
            dependencies: ["LoopImageCarousel"]),
    ]
)
```
