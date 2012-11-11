package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Pack extends Object implements IDataCenter
    {
        public var id:int;
        public var name:String;
        public var hasSubAreas:Boolean;
        private static const MODULE:String = "Pack";

        public function Pack()
        {
            return;
        }// end function

        public static function getPackById(param1:int) : Pack
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getPackByName(param1:String) : Pack
        {
            var _loc_3:* = null;
            var _loc_2:* = getAllPacks();
            for each (_loc_3 in _loc_2)
            {
                
                if (param1 == _loc_3.name)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public static function getAllPacks() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
