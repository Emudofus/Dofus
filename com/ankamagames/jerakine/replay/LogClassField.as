package com.ankamagames.jerakine.replay
{
    public class LogClassField 
    {

        public var fieldNameId:uint;
        public var type:int;
        public var transient:Boolean;

        public function LogClassField(fieldNameId:uint, type:int, transient:Boolean)
        {
            this.fieldNameId = fieldNameId;
            this.type = type;
            this.transient = transient;
        }

    }
}//package com.ankamagames.jerakine.replay

