package com.ankamagames.dofus.datacenter.world
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class WorldMap extends Object implements IDataCenter
    {
        public var id:int;
        public var origineX:int;
        public var origineY:int;
        public var mapWidth:Number;
        public var mapHeight:Number;
        public var horizontalChunck:uint;
        public var verticalChunck:uint;
        public var viewableEverywhere:Boolean;
        public var minScale:Number;
        public var maxScale:Number;
        public var startScale:Number;
        public var centerX:int;
        public var centerY:int;
        public var totalWidth:int;
        public var totalHeight:int;
        public var zoom:Vector.<String>;
        private static const MODULE:String = "WorldMaps";

        public function WorldMap()
        {
            return;
        }// end function

        public static function getWorldMapById(param1:int) : WorldMap
        {
            return GameData.getObject(MODULE, param1) as WorldMap;
        }// end function

    }
}
