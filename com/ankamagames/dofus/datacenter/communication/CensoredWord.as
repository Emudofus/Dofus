package com.ankamagames.dofus.datacenter.communication
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class CensoredWord extends Object implements IDataCenter
    {
        public var id:uint;
        public var listId:uint;
        public var language:String;
        public var word:String;
        public var deepLooking:Boolean;
        private static const MODULE:String = "CensoredWords";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CensoredWord));

        public function CensoredWord()
        {
            return;
        }// end function

        public static function getCensoredWordById(param1:int) : CensoredWord
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getCensoredWords() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
