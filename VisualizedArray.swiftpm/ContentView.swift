import SwiftUI

struct ContentView: View {
    
    @State var arr = VisualizedArray()
    
    @State var hasStartedAnimating = false
    @State var arrAnimationView: VisualizedArray.AnimationView?
    
    
    var body: some View {
        VStack {
            Spacer()
            
            if let animationView = arrAnimationView {
                HStack {
                    Spacer()
                    animationView
                    Spacer()
                }
            }

            Spacer()
            
            Button {
                if !hasStartedAnimating {
                    hasStartedAnimating = true
                    arrAnimationView = arr.animated()
                    arrAnimationView?.begin()
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Start Animation")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 12.5)
                .background(
                    RoundedRectangle(cornerRadius: 9)
                        .fill(.blue)
                )
            }
        }
        .padding()
        .onAppear {
            let nums = (1...10).shuffled()
            arr.append(contentsOf: nums)
            
//            arr.bubbleSort()
//            arr.insertionSort()
            arr.selectionSort()
//            arr.quickSort()
            print(arr)
        }
    }
    
}
    
extension VisualizedArray {
    mutating func bubbleSort() {
        guard count > 1 else {
            return
        }
        for i in 0..<count {
            for j in 0..<(count - i - 1) {
                if self[j] > self[j + 1] {
                    swapAt(j + 1, j)
                }
            }
        }
    }
        
    mutating func selectionSort() {
        for iterationIndex in 0 ..< self.count - 1 {
            
            var minIndex = iterationIndex
            
            for compareIndex in iterationIndex + 1 ..< self.count {
                if self[compareIndex] < self[minIndex] {
                    minIndex = compareIndex
                }
            }
            
            swapAt(iterationIndex, minIndex)
        }
    }
        
    mutating func insertionSort() {
        for i in 1..<count {
            var j = i
            while j > 0 && self[j] < self[j - 1] {
                swapAt(j - 1, j)
                j -= 1
            }
        }
    }
    
    mutating func quickSort() {
        quickSort(startIndex: 0, endIndex: count - 1)
    }
    
    // Quick sort helper method
    private mutating func quickSort(startIndex: Int, endIndex: Int) {
        if startIndex >= endIndex {
            return
        }
        let placedItemIndex = partition(startIndex: startIndex, endIndex: endIndex)
        quickSort(startIndex: startIndex, endIndex: placedItemIndex - 1)
        quickSort(startIndex: placedItemIndex + 1, endIndex: endIndex)
    }
    
    // Quick sort helper method
    private mutating func partition(startIndex: Int, endIndex: Int) -> Int {
        var q = startIndex
        for index in startIndex..<endIndex {
            if self[index] < self[endIndex] {
                swapAt(q, index)
                q += 1
            }
        }
        if q != endIndex {
            swapAt(q, endIndex)
        }
        
        return q
    }
}
