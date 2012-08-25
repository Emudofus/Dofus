package com.ankamagames.jerakine.utils.crypto
{
    import flash.events.*;
    import flash.utils.*;

    public class Base64Async extends EventDispatcher
    {
        private var _timer:Timer;
        private var _output:String;
        private var _data:IDataInput;
        private var _dataBuffer:Array;
        private var _outputBuffer:Array;
        private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        private static const STEP_LOOP:uint = 80000;
        public static const version:String = "1.1.0";

        public function Base64Async()
        {
            this._timer = new Timer(100);
            return;
        }// end function

        public function encode(param1:String) : void
        {
            if (this._timer.running)
            {
                throw new Error("Base64Async is buzy");
            }
            var _loc_2:* = new ByteArray();
            _loc_2.writeUTFBytes(param1);
            this.encodeByteArray(_loc_2);
            return;
        }// end function

        public function encodeByteArray(param1:IDataInput) : void
        {
            if (this._timer.running)
            {
                throw new Error("Base64Async is buzy");
            }
            this._output = "";
            this._data = param1;
            this._outputBuffer = new Array(4);
            this._data["position"] = 0;
            this._timer.addEventListener(TimerEvent.TIMER, this.encodeByteArrayStep);
            this._timer.start();
            return;
        }// end function

        public function get encodedOutput() : String
        {
            return this._output;
        }// end function

        private function encodeByteArrayStep(event:Event) : void
        {
            var _loc_3:uint = 0;
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            var _loc_2:* = STEP_LOOP;
            while (this._data.bytesAvailable > 0 && _loc_2--)
            {
                
                this._dataBuffer = new Array();
                _loc_3 = 0;
                while (_loc_3 < 3 && this._data.bytesAvailable > 0)
                {
                    
                    this._dataBuffer[_loc_3] = this._data.readUnsignedByte();
                    _loc_3 = _loc_3 + 1;
                }
                this._outputBuffer[0] = (this._dataBuffer[0] & 252) >> 2;
                this._outputBuffer[1] = (this._dataBuffer[0] & 3) << 4 | this._dataBuffer[1] >> 4;
                this._outputBuffer[2] = (this._dataBuffer[1] & 15) << 2 | this._dataBuffer[2] >> 6;
                this._outputBuffer[3] = this._dataBuffer[2] & 63;
                _loc_4 = this._dataBuffer.length;
                while (_loc_4 < 3)
                {
                    
                    this._outputBuffer[(_loc_4 + 1)] = 64;
                    _loc_4 = _loc_4 + 1;
                }
                _loc_5 = 0;
                while (_loc_5 < this._outputBuffer.length)
                {
                    
                    this._output = this._output + BASE64_CHARS.charAt(this._outputBuffer[_loc_5]);
                    _loc_5 = _loc_5 + 1;
                }
            }
            if (!this._data.bytesAvailable)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.encodeByteArrayStep);
                this._outputBuffer = null;
                this._dataBuffer = null;
                this._data = null;
                dispatchEvent(new Event(Event.COMPLETE));
            }
            else
            {
                dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, this._data["length"] - this._data.bytesAvailable, this._data["length"]));
            }
            return;
        }// end function

    }
}
