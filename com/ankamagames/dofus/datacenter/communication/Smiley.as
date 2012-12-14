package com.ankamagames.dofus.datacenter.communication
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Smiley extends Object implements IDataCenter
    {
        public var id:uint;
        public var order:uint;
        public var gfxId:String;
        public var forPlayers:Boolean;
        public var triggers:Vector.<String>;
        private static const MODULE:String = "Smileys";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Smiley));

        public function Smiley()
        {
            return;
        }// end function

        public static function getSmileyById(param1:int) : Smiley
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getSmileys() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
