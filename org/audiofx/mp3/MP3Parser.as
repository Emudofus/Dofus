package org.audiofx.mp3
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    class MP3Parser extends EventDispatcher
    {
        private var mp3Data:ByteArray;
        private var loader:URLLoader;
        private var currentPosition:uint;
        private var sampleRate:uint;
        private var channels:uint;
        private var version:uint;
        private var m_parent:MP3FileReferenceLoader;
        private static var bitRates:Array = [-1, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, -1, -1, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, -1];
        private static var versions:Array = [2.5, -1, 2, 1];
        private static var samplingRates:Array = [44100, 48000, 32000];

        function MP3Parser(param1:MP3FileReferenceLoader)
        {
            this.loader = new URLLoader();
            this.loader.dataFormat = URLLoaderDataFormat.BINARY;
            this.loader.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
            this.m_parent = param1;
            return;
        }// end function

        public function loadMP3ByteArray(param1:ByteArray) : void
        {
            this.mp3Data = param1;
            this.currentPosition = this.getFirstHeaderPosition();
            this.m_parent.parsingDone(this);
            return;
        }// end function

        function load(param1:String) : void
        {
            var _loc_2:* = new URLRequest(param1);
            this.loader.load(_loc_2);
            return;
        }// end function

        function loadFileRef(param1:FileReference) : void
        {
            param1.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
            param1.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            param1.load();
            return;
        }// end function

        private function errorHandler(event:IOErrorEvent) : void
        {
            trace("error\n" + event.text);
            return;
        }// end function

        private function loaderCompleteHandler(event:Event) : void
        {
            this.mp3Data = event.currentTarget.data as ByteArray;
            this.currentPosition = this.getFirstHeaderPosition();
            dispatchEvent(event);
            return;
        }// end function

        private function getFirstHeaderPosition() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this.mp3Data.position = 0;
            while (this.mp3Data.position < this.mp3Data.length)
            {
                
                _loc_1 = this.mp3Data.position;
                _loc_2 = this.mp3Data.readUTFBytes(3);
                if (_loc_2 == "ID3")
                {
                    this.mp3Data.position = this.mp3Data.position + 3;
                    _loc_4 = (this.mp3Data.readByte() & 127) << 21;
                    _loc_5 = (this.mp3Data.readByte() & 127) << 14;
                    _loc_6 = (this.mp3Data.readByte() & 127) << 7;
                    _loc_7 = this.mp3Data.readByte() & 127;
                    _loc_8 = _loc_7 + _loc_6 + _loc_5 + _loc_4;
                    _loc_9 = this.mp3Data.position + _loc_8;
                    this.mp3Data.position = _loc_9;
                    _loc_1 = _loc_9;
                }
                else
                {
                    this.mp3Data.position = _loc_1;
                }
                _loc_3 = this.mp3Data.readInt();
                if (this.isValidHeader(_loc_3))
                {
                    this.parseHeader(_loc_3);
                    this.mp3Data.position = _loc_1 + this.getFrameSize(_loc_3);
                    if (this.isValidHeader(this.mp3Data.readInt()))
                    {
                        return _loc_1;
                    }
                }
            }
            throw new Error("Could not locate first header. This isn\'t an MP3 file");
        }// end function

        function getNextFrame() : ByteArraySegment
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            this.mp3Data.position = this.currentPosition;
            while (true)
            {
                
                if (this.currentPosition > this.mp3Data.length - 4)
                {
                    trace("passed eof");
                    return null;
                }
                _loc_1 = this.mp3Data.readInt();
                if (this.isValidHeader(_loc_1))
                {
                    _loc_2 = this.getFrameSize(_loc_1);
                    if (_loc_2 != 4294967295)
                    {
                        break;
                    }
                }
                this.currentPosition = this.mp3Data.position;
            }
            this.mp3Data.position = this.currentPosition;
            if (this.currentPosition + _loc_2 > this.mp3Data.length)
            {
                return null;
            }
            this.currentPosition = this.currentPosition + _loc_2;
            return new ByteArraySegment(this.mp3Data, this.mp3Data.position, _loc_2);
        }// end function

        function writeSwfFormatByte(param1:ByteArray) : void
        {
            var _loc_2:* = 4 - 44100 / this.sampleRate;
            param1.writeByte((2 << 4) + (_loc_2 << 2) + (1 << 1) + (this.channels - 1));
            return;
        }// end function

        private function parseHeader(param1:uint) : void
        {
            var _loc_2:* = this.getModeIndex(param1);
            this.version = this.getVersionIndex(param1);
            var _loc_3:* = this.getFrequencyIndex(param1);
            this.channels = _loc_2 > 2 ? (1) : (2);
            var _loc_4:* = versions[this.version];
            var _loc_5:* = [44100, 48000, 32000];
            this.sampleRate = _loc_5[_loc_3];
            switch(_loc_4)
            {
                case 2:
                {
                    this.sampleRate = this.sampleRate / 2;
                    break;
                }
                case 2.5:
                {
                    this.sampleRate = this.sampleRate / 4;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getFrameSize(param1:uint) : uint
        {
            var _loc_2:* = this.getVersionIndex(param1);
            var _loc_3:* = this.getBitrateIndex(param1);
            var _loc_4:* = this.getFrequencyIndex(param1);
            var _loc_5:* = this.getPaddingBit(param1);
            var _loc_6:* = this.getModeIndex(param1);
            var _loc_7:* = versions[_loc_2];
            var _loc_8:* = samplingRates[_loc_4];
            if (this.version != _loc_2)
            {
                return 4294967295;
            }
            switch(_loc_7)
            {
                case 2:
                {
                    _loc_8 = _loc_8 / 2;
                    break;
                }
                case 2.5:
                {
                    _loc_8 = _loc_8 / 4;
                }
                default:
                {
                    break;
                }
            }
            var _loc_9:* = (_loc_7 == 1 ? (0) : (1)) * bitRates.length / 2;
            var _loc_10:* = bitRates[_loc_9 + _loc_3] * 1000;
            var _loc_11:* = (_loc_7 == 1 ? (144) : (72)) * _loc_10 / _loc_8 + _loc_5;
            return (_loc_7 == 1 ? (144) : (72)) * _loc_10 / _loc_8 + _loc_5;
        }// end function

        private function isValidHeader(param1:uint) : Boolean
        {
            return (this.getFrameSync(param1) & 2047) == 2047 && (this.getVersionIndex(param1) & 3) != 1 && (this.getLayerIndex(param1) & 3) != 0 && (this.getBitrateIndex(param1) & 15) != 0 && (this.getBitrateIndex(param1) & 15) != 15 && (this.getFrequencyIndex(param1) & 3) != 3 && (this.getEmphasisIndex(param1) & 3) != 2;
        }// end function

        private function getFrameSync(param1:uint) : uint
        {
            return uint(param1 >> 21 & 2047);
        }// end function

        private function getVersionIndex(param1:uint) : uint
        {
            return uint(param1 >> 19 & 3);
        }// end function

        private function getLayerIndex(param1:uint) : uint
        {
            return uint(param1 >> 17 & 3);
        }// end function

        private function getBitrateIndex(param1:uint) : uint
        {
            return uint(param1 >> 12 & 15);
        }// end function

        private function getFrequencyIndex(param1:uint) : uint
        {
            return uint(param1 >> 10 & 3);
        }// end function

        private function getPaddingBit(param1:uint) : uint
        {
            return uint(param1 >> 9 & 1);
        }// end function

        private function getModeIndex(param1:uint) : uint
        {
            return uint(param1 >> 6 & 3);
        }// end function

        private function getEmphasisIndex(param1:uint) : uint
        {
            return uint(param1 & 3);
        }// end function

    }
}
