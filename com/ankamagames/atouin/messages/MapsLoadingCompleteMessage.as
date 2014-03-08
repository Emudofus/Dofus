package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.atouin.data.map.Map;
   
   public class MapsLoadingCompleteMessage extends MapMessage
   {
      
      public function MapsLoadingCompleteMessage(mapPoint:WorldPoint, mapData:Map) {
         super();
         this._map = mapPoint;
         this._mapData = mapData;
      }
      
      private var _map:WorldPoint;
      
      private var _mapData:Map;
      
      public function get mapPoint() : WorldPoint {
         return this._map;
      }
      
      public function get mapData() : Map {
         return this._mapData;
      }
   }
}
