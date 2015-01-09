package com.ankamagames.dofus.datacenter.livingObjects
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class SpeakingItemsTrigger implements IDataCenter 
    {

        public static const MODULE:String = "SpeakingItemsTriggers";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemsTrigger));

        public var triggersId:int;
        public var textIds:Vector.<int>;
        public var states:Vector.<int>;


        public static function getSpeakingItemsTriggerById(id:int):SpeakingItemsTrigger
        {
            return ((GameData.getObject(MODULE, id) as SpeakingItemsTrigger));
        }

        public static function getSpeakingItemsTriggers():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.livingObjects

