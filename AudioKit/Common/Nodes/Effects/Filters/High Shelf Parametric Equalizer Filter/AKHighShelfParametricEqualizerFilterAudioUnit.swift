// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AVFoundation

public class AKHighShelfParametricEqualizerFilterAudioUnit: AKAudioUnitBase {

    func setParameter(_ address: AKHighShelfParametricEqualizerFilterParameter, value: Double) {
        setParameterWithAddress(address.rawValue, value: Float(value))
    }

    func setParameterImmediately(_ address: AKHighShelfParametricEqualizerFilterParameter, value: Double) {
        setParameterImmediatelyWithAddress(address.rawValue, value: Float(value))
    }

    var centerFrequency: Double = AKHighShelfParametricEqualizerFilter.defaultCenterFrequency {
        didSet { setParameter(.centerFrequency, value: centerFrequency) }
    }

    var gain: Double = AKHighShelfParametricEqualizerFilter.defaultGain {
        didSet { setParameter(.gain, value: gain) }
    }

    var q: Double = AKHighShelfParametricEqualizerFilter.defaultQ {
        didSet { setParameter(.Q, value: q) }
    }

    var rampDuration: Double = 0.0 {
        didSet { setParameter(.rampDuration, value: rampDuration) }
    }

    public override func createDSP() -> AKDSPRef {
        return createHighShelfParametricEqualizerFilterDSP()
    }

    public override init(componentDescription: AudioComponentDescription,
                         options: AudioComponentInstantiationOptions = []) throws {
        try super.init(componentDescription: componentDescription, options: options)

        let centerFrequency = AUParameter(
            identifier: "centerFrequency",
            name: "Corner Frequency (Hz)",
            address: AKHighShelfParametricEqualizerFilterParameter.centerFrequency.rawValue,
            range: AKHighShelfParametricEqualizerFilter.centerFrequencyRange,
            unit: .hertz,
            flags: .default)
        let gain = AUParameter(
            identifier: "gain",
            name: "Gain",
            address: AKHighShelfParametricEqualizerFilterParameter.gain.rawValue,
            range: AKHighShelfParametricEqualizerFilter.gainRange,
            unit: .generic,
            flags: .default)
        let q = AUParameter(
            identifier: "q",
            name: "Q",
            address: AKHighShelfParametricEqualizerFilterParameter.Q.rawValue,
            range: AKHighShelfParametricEqualizerFilter.qRange,
            unit: .generic,
            flags: .default)

        setParameterTree(AUParameterTree(children: [centerFrequency, gain, q]))
        centerFrequency.value = Float(AKHighShelfParametricEqualizerFilter.defaultCenterFrequency)
        gain.value = Float(AKHighShelfParametricEqualizerFilter.defaultGain)
        q.value = Float(AKHighShelfParametricEqualizerFilter.defaultQ)
    }

    public override var canProcessInPlace: Bool { return true }

}
