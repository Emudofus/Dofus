package com.ankamagames.dofus.kernel.sound.type
{
    import flash.geom.*;

    public class LocalizedMapSound extends Object
    {
        public var soundId:String;
        public var position:Point;
        public var range:int;
        public var saturationRange:int;
        public var silenceMin:int;
        public var silenceMax:int;
        public var volumeMax:Number;

        public function LocalizedMapSound(param1:String, param2:Point, param3:int, param4:int, param5:int, param6:int, param7:Number)
        {
            this.soundId = param1;
            this.position = param2;
            this.range = param3;
            this.saturationRange = param4;
            this.silenceMin = param5;
            this.silenceMax = param6;
            this.volumeMax = param7;
            return;
        }// end function

    }
}
