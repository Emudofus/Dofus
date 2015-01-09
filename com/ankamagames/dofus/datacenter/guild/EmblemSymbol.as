package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;

    public class EmblemSymbol implements IDataCenter 
    {

        public static const MODULE:String = "EmblemSymbols";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemSymbol));

        public var id:int;
        public var iconId:int;
        public var skinId:int;
        public var order:int;
        public var categoryId:int;
        public var colorizable:Boolean;


        public static function getEmblemSymbolById(id:int):EmblemSymbol
        {
            return ((GameData.getObject(MODULE, id) as EmblemSymbol));
        }

        public static function getEmblemSymbols():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.guild

