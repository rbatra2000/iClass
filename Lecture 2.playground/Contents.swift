
func randomize() -> [String] {
    let sequence = ["image-1","image-2","image-3","image-4","image-5","image-6","image-7","image-8","image-9","image-10","image-11","image-12"]
    let shuffledSequence = sequence.shuffled()
    var allImages:[String] = []
    
    var i = 0
    while i < 12 {
        allImages.append(shuffledSequence[i])
        i += 1
    }
    return allImages
}

var f = randomize()
