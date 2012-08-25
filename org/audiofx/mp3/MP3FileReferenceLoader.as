package org.audiofx.mp3
{
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class MP3FileReferenceLoader extends EventDispatcher
    {
        private var mp3Parser:MP3Parser;

        public function MP3FileReferenceLoader()
        {
            this.mp3Parser = new MP3Parser(this);
            this.mp3Parser.addEventListener(Event.COMPLETE, this.parserCompleteHandler);
            return;
        }// end function

        public function loadMP3ByteArray(param1:ByteArray) : void
        {
            this.mp3Parser.loadMP3ByteArray(param1);
            return;
        }// end function

        public function parsingDone(param1:MP3Parser) : void
        {
            this.generateSound(param1);
            return;
        }// end function

        public function getSound(param1:FileReference) : void
        {
            this.mp3Parser.loadFileRef(param1);
            return;
        }// end function

        private function parserCompleteHandler(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as MP3Parser;
            this.generateSound(_loc_2);
            return;
        }// end function

        private function generateSound(param1:MP3Parser) : Boolean
        {
            var _loc_12:ByteArraySegment = null;
            var _loc_2:* = new ByteArray();
            _loc_2.endian = Endian.LITTLE_ENDIAN;
            var _loc_3:uint = 0;
            while (_loc_3 < SoundClassSwfByteCode.soundClassSwfBytes1.length)
            {
                
                _loc_2.writeByte(SoundClassSwfByteCode.soundClassSwfBytes1[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = _loc_2.position;
            _loc_2.writeInt(0);
            _loc_3 = 0;
            while (_loc_3 < SoundClassSwfByteCode.soundClassSwfBytes2.length)
            {
                
                _loc_2.writeByte(SoundClassSwfByteCode.soundClassSwfBytes2[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_5:* = _loc_2.position;
            _loc_2.writeInt(0);
            _loc_2.writeByte(1);
            _loc_2.writeByte(0);
            param1.writeSwfFormatByte(_loc_2);
            var _loc_6:* = _loc_2.position;
            _loc_2.writeInt(0);
            _loc_2.writeByte(0);
            _loc_2.writeByte(0);
            var _loc_7:uint = 0;
            var _loc_8:uint = 0;
            while (true)
            {
                
                _loc_12 = param1.getNextFrame();
                if (_loc_12 == null)
                {
                    break;
                }
                _loc_2.writeBytes(_loc_12.byteArray, _loc_12.start, _loc_12.length);
                _loc_8 = _loc_8 + _loc_12.length;
                _loc_7 = _loc_7 + 1;
            }
            if (_loc_8 == 0)
            {
                return false;
            }
            _loc_8 = _loc_8 + 2;
            var _loc_9:* = _loc_2.position;
            _loc_2.position = _loc_5;
            _loc_2.writeInt(_loc_8 + 7);
            _loc_2.position = _loc_6;
            _loc_2.writeInt(_loc_7 * 1152);
            _loc_2.position = _loc_9;
            _loc_3 = 0;
            while (_loc_3 < SoundClassSwfByteCode.soundClassSwfBytes3.length)
            {
                
                _loc_2.writeByte(SoundClassSwfByteCode.soundClassSwfBytes3[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            _loc_2.position = _loc_4;
            _loc_2.writeInt(_loc_2.length);
            _loc_2.position = 0;
            var _loc_10:* = new Loader();
            new Loader().contentLoaderInfo.addEventListener(Event.COMPLETE, this.swfCreated);
            var _loc_11:* = new LoaderContext();
            AirScanner.hasAir();
            _loc_11["allowLoadBytesCodeExecution"] = true;
            _loc_10.loadBytes(_loc_2, _loc_11);
            return true;
        }// end function

        private function swfCreated(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as LoaderInfo;
            var _loc_3:* = _loc_2.applicationDomain.getDefinition("SoundClass") as Class;
            var _loc_4:* = new _loc_3;
            dispatchEvent(new MP3SoundEvent(MP3SoundEvent.COMPLETE, _loc_4));
            return;
        }// end function

    }
}
