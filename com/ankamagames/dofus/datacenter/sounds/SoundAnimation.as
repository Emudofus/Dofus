package com.ankamagames.dofus.datacenter.sounds
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SoundAnimation extends Object implements IDataCenter
    {
        public var id:uint;
        public var name:String;
        public var label:String;
        public var filename:String;
        public var volume:int;
        public var rolloff:int;
        public var automationDuration:int;
        public var automationVolume:int;
        public var automationFadeIn:int;
        public var automationFadeOut:int;
        public var noCutSilence:Boolean;
        public var startFrame:uint;
        public static var MODULE:String = "SoundAnimations";

        public function SoundAnimation()
        {
            return;
        }// end function

        public static function getSoundAnimationById(param1:uint) : SoundAnimation
        {
            return GameData.getObject(MODULE, param1) as SoundAnimation;
        }// end function

        public static function getSoundAnimations() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
