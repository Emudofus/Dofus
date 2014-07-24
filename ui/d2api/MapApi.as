package d2api
{
   import d2data.SubArea;
   import d2data.WorldMap;
   import d2data.WorldPoint;
   import d2data.MapPosition;
   
   public class MapApi extends Object
   {
      
      public function MapApi() {
         super();
      }
      
      public function getCurrentSubArea() : SubArea {
         return null;
      }
      
      public function getCurrentWorldMap() : WorldMap {
         return null;
      }
      
      public function getAllSuperArea() : Object {
         return null;
      }
      
      public function getAllArea() : Object {
         return null;
      }
      
      public function getAllSubArea() : Object {
         return null;
      }
      
      public function getSubArea(subAreaId:uint) : SubArea {
         return null;
      }
      
      public function getSubAreaMapIds(subAreaId:uint) : Object {
         return null;
      }
      
      public function getSubAreaCenter(subAreaId:uint) : Object {
         return null;
      }
      
      public function getWorldPoint(mapId:uint) : WorldPoint {
         return null;
      }
      
      public function getMapCoords(mapId:uint) : Object {
         return null;
      }
      
      public function getSubAreaShape(subAreaId:uint) : Object {
         return null;
      }
      
      public function getHintIds() : Object {
         return null;
      }
      
      public function subAreaByMapId(mapId:uint) : SubArea {
         return null;
      }
      
      public function getMapIdByCoord(x:int, y:int) : Object {
         return null;
      }
      
      public function getMapPositionById(mapId:uint) : MapPosition {
         return null;
      }
      
      public function intersects(rect1:Object, rect2:Object) : Boolean {
         return false;
      }
      
      public function movePlayer(x:int, y:int, world:int = -1) : void {
      }
      
      public function movePlayerOnMapId(mapId:uint) : void {
      }
      
      public function getMapReference(refId:uint) : Object {
         return null;
      }
      
      public function getPhoenixsMaps() : Object {
         return null;
      }
      
      public function getClosestPhoenixMap() : uint {
         return 0;
      }
      
      public function isInIncarnam() : Boolean {
         return false;
      }
   }
}
