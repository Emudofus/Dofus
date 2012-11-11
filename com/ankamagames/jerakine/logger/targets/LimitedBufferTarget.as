package com.ankamagames.jerakine.logger.targets
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.json.*;
    import com.ankamagames.jerakine.logger.*;
    import com.hurlant.util.*;

    public class LimitedBufferTarget extends AbstractTarget
    {
        private var _buffer:Vector.<LogEvent>;
        private var _limit:int;

        public function LimitedBufferTarget(param1:int = 50)
        {
            this._limit = param1;
            this._buffer = new Vector.<LogEvent>;
            return;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            if (this._buffer.length >= this._limit)
            {
                this._buffer.shift();
            }
            this._buffer.push(event);
            return;
        }// end function

        public function getFormatedBuffer() : String
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._buffer)
            {
                
                _loc_3 = new Object();
                _loc_3.message = _loc_2.message;
                _loc_3.level = _loc_2.level;
                _loc_1.push(_loc_3);
            }
            _loc_4 = JSON.encode(_loc_1);
            return Base64.encode(_loc_4);
        }// end function

        public function clearBuffer() : void
        {
            this._buffer = new Vector.<LogEvent>;
            return;
        }// end function

    }
}
