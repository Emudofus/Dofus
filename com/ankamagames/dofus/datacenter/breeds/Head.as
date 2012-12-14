package com.ankamagames.dofus.datacenter.breeds
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Head extends Object implements IDataCenter
    {
        public var id:int;
        public var skins:String;
        public var assetId:String;
        public var breed:uint;
        public var gender:uint;
        public var order:uint;
        private static const MODULE:String = "Heads";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Head));

        public function Head()
        {
            return;
        }// end function

        public static function getHeadById(param1:int) : Head
        {
            return GameData.getObject(MODULE, param1) as Head;
        }// end function

        public static function getHeads() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
