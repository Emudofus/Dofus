package com.ankamagames.jerakine.types
{

    public class SoundEventParamWrapper extends Object
    {
        public var id:String;
        public var volume:uint;
        public var rollOff:uint;
        public var berceauDuree:int;
        public var berceauVol:int;
        public var berceauFadeIn:int;
        public var berceauFadeOut:int;
        public var noCutSilence:Boolean;

        public function SoundEventParamWrapper(param1:String, param2:uint, param3:uint, param4:int = -1, param5:int = -1, param6:int = -1, param7:int = -1, param8:Boolean = false)
        {
            this.id = param1;
            this.volume = param2;
            this.rollOff = param3;
            this.berceauDuree = param4;
            this.berceauVol = param5;
            this.berceauFadeIn = param6;
            this.berceauFadeOut = param7;
            this.noCutSilence = param8;
            return;
        }// end function

    }
}
