// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKBrownianNoiseTests: AKTestCase {

    func testDefault() {
        output = AKBrownianNoise()
        AKTestMD5("1f0779829a4125f460d9aa33e23741b5")
    }

    func testAmplitude() {
        output = AKBrownianNoise(amplitude: 0.5)
        AKTestMD5("87fc12e85351b242d0086396e36f0fab")
    }
}
