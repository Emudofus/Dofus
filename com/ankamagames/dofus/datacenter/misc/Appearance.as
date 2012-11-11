package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Appearance extends Object implements IDataCenter
    {
        public var id:uint;
        public var type:uint;
        public var data:String;
        public static const MODULE:String = "Appearances";

        public function Appearance()
        {
            return;
        }// end function

        public static function getAppearanceById(param1:uint) : Appearance
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

    }
}
