package com.ankamagames.dofus.datacenter.communication
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;

    public class CensoredWord implements IDataCenter 
    {

        public static const MODULE:String = "CensoredWords";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CensoredWord));

        public var id:uint;
        public var listId:uint;
        public var language:String;
        public var word:String;
        public var deepLooking:Boolean;


        public static function getCensoredWordById(id:int):CensoredWord
        {
            return ((GameData.getObject(MODULE, id) as CensoredWord));
        }

        public static function getCensoredWords():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.communication

