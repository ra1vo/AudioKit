// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

#pragma once

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(AUParameterAddress, AKVariableDelayParameter) {
    AKVariableDelayParameterTime,
    AKVariableDelayParameterFeedback,
    AKVariableDelayParameterRampDuration
};

#ifndef __cplusplus

AKDSPRef createVariableDelayDSP(void);

#else

#import "AKSoundpipeDSPBase.hpp"

class AKVariableDelayDSP : public AKSoundpipeDSPBase {
private:
    struct InternalData;
    std::unique_ptr<InternalData> data;
 
public:
    AKVariableDelayDSP();

    float timeLowerBound = 0;
    float timeUpperBound = 10;
    float feedbackLowerBound = 0;
    float feedbackUpperBound = 1;

    float defaultTime = 0;
    float defaultFeedback = 0;

    int defaultRampDurationSamples = 10000;

    // Uses the ParameterAddress as a key
    void setParameter(AUParameterAddress address, float value, bool immediate) override;

    // Uses the ParameterAddress as a key
    float getParameter(AUParameterAddress address) override;
    
    void init(int channelCount, double sampleRate) override;

    void clear() override;
    void deinit() override;

    void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) override;
};

#endif
