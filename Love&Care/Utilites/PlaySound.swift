import Foundation
import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(soundFile: String, soundType: String) {
    
    if let path = Bundle.main.path(forResource: soundFile, ofType: soundType) {
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
