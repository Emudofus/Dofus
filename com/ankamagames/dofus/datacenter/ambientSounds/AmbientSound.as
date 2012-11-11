package com.ankamagames.dofus.datacenter.ambientSounds
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AmbientSound extends Object implements IDataCenter
    {
        public var id:int;
        public var volume:uint;
        public var criterionId:int;
        public var silenceMin:uint;
        public var silenceMax:uint;
        public var channel:int;
        public var type_id:int;
        public static const AMBIENT_TYPE_ROLEPLAY:int = 1;
        public static const AMBIENT_TYPE_AMBIENT:int = 2;
        public static const AMBIENT_TYPE_FIGHT:int = 3;
        public static const AMBIENT_TYPE_BOSS:int = 4;
        private static const MODULE:String = "AmbientSounds";

        public function AmbientSound()
        {
            return;
        }// end function

        public static function getAmbientSoundById(param1:uint) : AmbientSound
        {
            return GameData.getObject(MODULE, param1) as AmbientSound;
        }// end function

    }
}
