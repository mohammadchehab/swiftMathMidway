import SwiftUI
import SlidingRuler

struct MidwaySlider: View {
    
    @ObservedObject var sliderData = SliderModel()
    
    var body: some View {
        VStack {
            SlidingRuler(value: $sliderData.sliderValue, in: sliderData.currentSliderRange, step: 1)
                .id(sliderData.id)
                .padding()
             
            Text("\(Int(sliderData.sliderValue))")
                .padding()
        }
    }
}

struct MidwaySlider_Previews: PreviewProvider {
    static var previews: some View {
        let sliderData = SliderModel() // Create an instance of SliderObservableData

        return MidwaySlider(sliderData: sliderData)
            .environmentObject(sliderData) // Inject the observable object into the view hierarchy
    }
}

