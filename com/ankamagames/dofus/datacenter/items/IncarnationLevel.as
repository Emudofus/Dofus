package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class IncarnationLevel extends Object implements IDataCenter
    {
        public var id:int;
        public var incarnationId:int;
        public var level:int;
        public var requiredXp:uint;
        private static const MODULE:String = "IncarnationLevels";

        public function IncarnationLevel()
        {
            return;
        }// end function

        public function get incarnation() : Incarnation
        {
            return Incarnation.getIncarnationById(this.id);
        }// end function

        public static function getIncarnationLevelById(param1:uint) : IncarnationLevel
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getIncarnationLevelByIdAndLevel(param1:int, param2:int) : IncarnationLevel
        {
            var _loc_3:* = param1 * 100 + param2;
            return getIncarnationLevelById(_loc_3);
        }// end function

    }
}
