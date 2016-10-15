# sample-pack-generator

ChucK script to sequentially play notes on a MIDI device, which can be used for sampling all sounds from a drum machine or any MIDI device.

## Requirements

* ChucK available in PATH
* Audio recording device
* MIDI interface
* Prior knowledge of longest sample duration on your device

## Usage

So far I've only created a script to [record all samples from a Korg EMX](emx.ck), but this can be adapted for use with other devices.
Check your device's MIDI implementation chart.

1. Run `chuck --probe` to find the ID of your MIDI output device
2. Configure your device's levels, settings, MIDI channels, etc
3. Start recording audio
4. To start sample playback, run `chuck NrpnData.ck Nrpn.ck emx.ck:MIDI_DEVICE`, where `MIDI_DEVICE` is the ID obtained in step 1
5. Wait until the script finishes
6. Split the recorded audio into samples ([example on doing this automatically](https://rolodato.com/2016/10/14/emx-sample-pack.html))

## Improvements

This implementation is far from ideal but it suits my needs.
If anyone is up to it, these would be some nice improvements to have:

- [ ] Detect when each sample has finished playing by measuring audio input level (add some extra duration as a buffer)
- [ ] Output individual sample files from ChucK directly

Any of these improvements would add the requirement to have an audio interface usable from ChucK.
