package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class EmblemSymbol extends Object implements IDataCenter
    {
        public var id:int;
        public var iconId:int;
        public var skinId:int;
        public var order:int;
        public var categoryId:int;
        public var colorizable:Boolean;
        private static const MODULE:String = "EmblemSymbols";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemSymbol));

        public function EmblemSymbol()
        {
            return;
        }// end function

        public static function getEmblemSymbolById(param1:int) : EmblemSymbol
        {
            return GameData.getObject(MODULE, param1) as EmblemSymbol;
        }// end function

        public static function getEmblemSymbols() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
