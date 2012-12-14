package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SkinMapping extends Object implements IDataCenter
    {
        public var id:int;
        public var lowDefId:int;
        private static const MODULE:String = "SkinMappings";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(SkinMapping));

        public function SkinMapping()
        {
            return;
        }// end function

        public static function getSkinMappingById(param1:int) : SkinMapping
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getSkinMappings() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
