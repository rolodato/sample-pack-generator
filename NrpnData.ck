public class NrpnData {
    MidiMsg data[];
    function static NrpnData create(MidiMsg data[]) {
        NrpnData msgs;
        data @=> msgs.data;
        return msgs;
    }
    function void send(MidiOut midiOut) {
        for (0 => int i; i < data.cap(); i++) {
            midiOut.send(data[i]);
        }
    }
}
