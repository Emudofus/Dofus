package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MapReference extends Object implements IDataCenter
    {
        public var id:int;
        public var mapId:uint;
        public var cellId:int;
        private static const MODULE:String = "MapReferences";

        public function MapReference()
        {
            return;
        }// end function

        public static function getMapReferenceById(param1:int) : MapReference
        {
            var _loc_2:* = GameData.getObject(MODULE, param1);
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getAllMapReference() : Array
        {
            return GameData.getObjects(MODULE) as Array;
        }// end function

    }
}
