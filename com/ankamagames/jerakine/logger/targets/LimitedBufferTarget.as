﻿package com.ankamagames.jerakine.logger.targets
{
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.logger.LogEvent;
    import com.ankamagames.jerakine.json.JSON;
    import com.hurlant.util.Base64;
    import __AS3__.vec.*;

    public class LimitedBufferTarget extends AbstractTarget 
    {

        private var _buffer:Vector.<LogEvent>;
        private var _limit:int;

        public function LimitedBufferTarget(pLimit:int=50)
        {
            this._limit = pLimit;
            this._buffer = new Vector.<LogEvent>();
        }

        override public function logEvent(event:LogEvent):void
        {
            if (this._buffer.length >= this._limit)
            {
                this._buffer.shift();
            };
            this._buffer.push(event);
        }

        public function getFormatedBuffer():String
        {
            var log:LogEvent;
            var obj:Object;
            var json:String;
            var newArray:Array = new Array();
            for each (log in this._buffer)
            {
                obj = new Object();
                obj.message = log.message;
                obj.level = log.level;
                newArray.push(obj);
            };
            json = JSON.encode(newArray);
            return (Base64.encode(json));
        }

        public function clearBuffer():void
        {
            this._buffer = new Vector.<LogEvent>();
        }


    }
}//package com.ankamagames.jerakine.logger.targets

