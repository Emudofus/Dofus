package com.ankamagames.dofus.datacenter.livingObjects
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SpeakingItemsTrigger extends Object implements IDataCenter
    {
        public var triggersId:int;
        public var textIds:Vector.<int>;
        public var states:Vector.<int>;
        private static const MODULE:String = "SpeakingItemsTriggers";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemsTrigger));

        public function SpeakingItemsTrigger()
        {
            return;
        }// end function

        public static function getSpeakingItemsTriggerById(param1:int) : SpeakingItemsTrigger
        {
            return GameData.getObject(MODULE, param1) as SpeakingItemsTrigger;
        }// end function

        public static function getSpeakingItemsTriggers() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
