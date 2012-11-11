package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class EmblemBackground extends Object implements IDataCenter
    {
        public var id:int;
        public var order:int;
        private static const MODULE:String = "EmblemBackgrounds";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemBackground));

        public function EmblemBackground()
        {
            return;
        }// end function

        public static function getEmblemBackgroundById(param1:int) : EmblemBackground
        {
            return GameData.getObject(MODULE, param1) as EmblemBackground;
        }// end function

        public static function getEmblemBackgrounds() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
