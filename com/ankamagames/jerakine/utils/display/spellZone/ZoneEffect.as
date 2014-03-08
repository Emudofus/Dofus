package com.ankamagames.jerakine.utils.display.spellZone
{
   public class ZoneEffect extends Object implements IZoneShape
   {
      
      public function ZoneEffect(param1:uint, param2:uint) {
         super();
         this._zoneSize = param1;
         this._zoneShape = param2;
      }
      
      private var _zoneSize:uint;
      
      private var _zoneShape:uint;
      
      public function get zoneSize() : uint {
         return this._zoneSize;
      }
      
      public function set zoneSize(param1:uint) : void {
         this._zoneSize = param1;
      }
      
      public function get zoneShape() : uint {
         return this._zoneShape;
      }
      
      public function set zoneShape(param1:uint) : void {
         this._zoneShape = param1;
      }
   }
}
