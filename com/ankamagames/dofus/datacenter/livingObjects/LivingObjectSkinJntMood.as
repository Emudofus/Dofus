package com.ankamagames.dofus.datacenter.livingObjects
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class LivingObjectSkinJntMood extends Object implements IDataCenter
    {
        public var skinId:int;
        public var moods:Vector.<Vector.<int>>;
        private static const MODULE:String = "LivingObjectSkinJntMood";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemText));

        public function LivingObjectSkinJntMood()
        {
            return;
        }// end function

        public static function getLivingObjectSkin(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = GameData.getObject(MODULE, param1) as ;
            if (!(GameData.getObject(MODULE, param1) as ) || !_loc_4.moods[param2])
            {
                return 0;
            }
            var _loc_5:* = _loc_4.moods[param2] as Vector.<int>;
            return (_loc_4.moods[param2] as Vector.<int>)[Math.max(0, (param3 - 1))];
        }// end function

        public static function getLivingObjectSkins() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
