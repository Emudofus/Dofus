package com.ankamagames.jerakine.replay
{
    public class MouseInteraction 
    {

        public var target:String;
        public var type:String;
        public var x:int;
        public var y:int;

        public function MouseInteraction(target:String=null, type:String=null, x:int=0, y:int=0)
        {
            this.target = target;
            this.type = type;
            this.x = x;
            this.y = y;
        }

        public function toString():String
        {
            return (((("MouseInteraction : " + this.type.split("::")[1]) + " on ") + this.target));
        }


    }
}//package com.ankamagames.jerakine.replay

