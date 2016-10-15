public class Nrpn {
    int paramMsb;
    int paramLsb;

    function static int msb(int value) {
      return (value >> 7);
    }

    function static int lsb(int value) {
        return value & 0x007f;
    }

    function static int channelNumber(int midiByte) {
        return (0x0f & midiByte) + 1;
    }

    function static int controlChange(int channel) {
        return 0xB0 | (channel - 1);
    }

    function static Nrpn create(int msb, int lsb) {
        Nrpn msg;
        msb => msg.paramMsb;
        lsb => msg.paramLsb;
        return msg;
    }

    function NrpnData toMidi(int channel, int value) {
        MidiMsg msg1;
        MidiMsg msg2;
        MidiMsg msg3;
        MidiMsg msg4;
        controlChange(channel) => int status;

        status => msg1.data1;
        0x63 => msg1.data2;
        paramMsb => msg1.data3;

        status => msg2.data1;
        0x62 => msg2.data2;
        paramLsb => msg2.data3;

        status => msg3.data1;
        0x6 => msg3.data2;
        msb(value) => msg3.data3;

        status => msg4.data1;
        0x26 => msg4.data2;
        lsb(value) => msg4.data3;

        return NrpnData.create([msg1, msg2, msg3, msg4]);
    }
}
