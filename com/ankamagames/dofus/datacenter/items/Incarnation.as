package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Incarnation extends Object implements IDataCenter
    {
        public var id:uint;
        public var lookMale:String;
        public var lookFemale:String;
        private static const MODULE:String = "Incarnation";
        private static var _incarnationsList:Array;

        public function Incarnation()
        {
            return;
        }// end function

        public static function getIncarnationById(param1:uint) : Incarnation
        {
            return GameData.getObject(MODULE, param1) as Incarnation;
        }// end function

        public static function getAllIncarnation() : Array
        {
            if (!_incarnationsList)
            {
                _incarnationsList = GameData.getObjects(MODULE) as Array;
            }
            return _incarnationsList;
        }// end function

    }
}
