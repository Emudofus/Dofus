package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.atouin.data.map.Map;
   
   public class MapsLoadingCompleteMessage extends MapMessage
   {
      
      public function MapsLoadingCompleteMessage(param1:WorldPoint, param2:Map) {
         super();
         this._map = param1;
         this._mapData = param2;
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
