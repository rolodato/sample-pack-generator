MidiOut mout;
int midiDevice;

if (me.args()) {
    me.arg(0) => Std.atoi => midiDevice;
} else {
    <<<"usage: chuck NrpnData.ck Nrpn.ck emx.ck:MIDI_DEVICE">>>;
    me.exit();
}

if (!mout.open(0)) {
    <<< "could not open MIDI output device" >>>;
    me.exit();
}

MidiMsg noteOn;
10 => int midiChannel;                  // EMX drums are on channel 10 by default
0x90 + midiChannel - 1 => noteOn.data1;
36 => noteOn.data2;                     // Drum part 1 is on C1
127 => noteOn.data3;                    // Needed, but EMX doesn't recognize velocity
3 => int maxSampleLength;               // Longest sample is 2.83 seconds long
207 => int sampleCount;

for (0 => int i; i < sampleCount; i++) {
    // Switch to sample
    // Values taken from MIDI implementation chart, see "Drum1 Wave" on page 6
    // http://www.korg-datastorage.jp/Software/MIDIImp/EMX.pdf
    Nrpn.create(0x09, 0x20) @=> Nrpn drumWave;
    drumWave.toMidi(midiChannel, i).send(mout);

    // Play sample
    mout.send(noteOn);

    // Wait until sample has finished playing
    maxSampleLength::second => now;
}

<<<"done!">>>;
