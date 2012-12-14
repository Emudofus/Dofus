package com.ankamagames.dofus.datacenter.sounds
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SoundUi extends Object implements IDataCenter
    {
        public var id:uint;
        public var uiName:String;
        public var openFile:String;
        public var closeFile:String;
        public var subElements:Vector.<SoundUiElement>;
        public static var MODULE:String = "SoundUi";

        public function SoundUi()
        {
            return;
        }// end function

        public static function getSoundUiById(param1:uint) : SoundUi
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as SoundUi;
            return _loc_2;
        }// end function

        public static function getSoundUis() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
