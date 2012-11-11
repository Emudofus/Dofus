package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class PresetIcon extends Object implements IDataCenter
    {
        public var id:int;
        public var order:int;
        private static const MODULE:String = "PresetIcons";

        public function PresetIcon()
        {
            return;
        }// end function

        public static function getPresetIconById(param1:int) : PresetIcon
        {
            return GameData.getObject(MODULE, param1) as PresetIcon;
        }// end function

        public static function getPresetIcons() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
