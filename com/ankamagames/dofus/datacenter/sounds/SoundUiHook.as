package com.ankamagames.dofus.datacenter.sounds
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SoundUiHook extends Object implements IDataCenter
    {
        public var id:uint;
        public var name:String;
        public static var MODULE:String = "SoundUiHook";

        public function SoundUiHook()
        {
            return;
        }// end function

        public static function getSoundUiHookById(param1:uint) : SoundUiHook
        {
            return GameData.getObject(MODULE, param1) as SoundUiHook;
        }// end function

        public static function getSoundUiHooks() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
