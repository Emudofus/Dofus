package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;

    public class EmblemBackground implements IDataCenter 
    {

        public static const MODULE:String = "EmblemBackgrounds";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemBackground));

        public var id:int;
        public var order:int;


        public static function getEmblemBackgroundById(id:int):EmblemBackground
        {
            return ((GameData.getObject(MODULE, id) as EmblemBackground));
        }

        public static function getEmblemBackgrounds():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.guild

