package d2api
{
    import d2data.SubArea;
    import d2data.WorldMap;
    import d2data.WorldPoint;
    import d2data.MapPosition;

    public class MapApi 
    {


        [Untrusted]
        public function getCurrentSubArea():SubArea
        {
            return (null);
        }

        [Untrusted]
        public function getCurrentWorldMap():WorldMap
        {
            return (null);
        }

        [Untrusted]
        public function getAllSuperArea():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAllArea():Object
        {
            return (null);
        }

        [Untrusted]
        public function getAllSubArea():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSubArea(subAreaId:uint):SubArea
        {
            return (null);
        }

        [Untrusted]
        public function getSubAreaMapIds(subAreaId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSubAreaCenter(subAreaId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getWorldPoint(mapId:uint):WorldPoint
        {
            return (null);
        }

        [Untrusted]
        public function getMapCoords(mapId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSubAreaShape(subAreaId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getHintIds():Object
        {
            return (null);
        }

        [Untrusted]
        public function subAreaByMapId(mapId:uint):SubArea
        {
            return (null);
        }

        [Untrusted]
        public function getMapIdByCoord(x:int, y:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getMapPositionById(mapId:uint):MapPosition
        {
            return (null);
        }

        [Untrusted]
        public function intersects(rect1:Object, rect2:Object):Boolean
        {
            return (false);
        }

        [Trusted]
        public function movePlayer(x:int, y:int, world:int=-1):void
        {
        }

        [Trusted]
        public function movePlayerOnMapId(mapId:uint):void
        {
        }

        [Untrusted]
        public function getMapReference(refId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getPhoenixsMaps():Object
        {
            return (null);
        }

        [Untrusted]
        public function getClosestPhoenixMap():uint
        {
            return (0);
        }

        [Trusted]
        public function isInIncarnam():Boolean
        {
            return (false);
        }


    }
}//package d2api

