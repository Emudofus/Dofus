package com.ankamagames.jerakine.types.positions
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   
   public class WorldPoint extends Object implements IDataCenter
   {
      
      public function WorldPoint() {
         super();
      }
      
      private static const WORLD_ID_MAX:uint = 2 << 12;
      
      private static const MAP_COORDS_MAX:uint = 2 << 8;
      
      public static function fromMapId(param1:uint) : WorldPoint {
         var _loc2_:WorldPoint = new WorldPoint();
         _loc2_._mapId = param1;
         _loc2_.setFromMapId();
         return _loc2_;
      }
      
      public static function fromCoords(param1:uint, param2:int, param3:int) : WorldPoint {
         var _loc4_:WorldPoint = new WorldPoint();
         _loc4_._worldId = param1;
         _loc4_._x = param2;
         _loc4_._y = param3;
         _loc4_.setFromCoords();
         return _loc4_;
      }
      
      private var _mapId:uint;
      
      private var _worldId:uint;
      
      private var _x:int;
      
      private var _y:int;
      
      public function get mapId() : uint {
         return this._mapId;
      }
      
      public function set mapId(param1:uint) : void {
         this._mapId = param1;
         this.setFromMapId();
      }
      
      public function get worldId() : uint {
         return this._worldId;
      }
      
      public function set worldId(param1:uint) : void {
         this._worldId = param1;
         this.setFromCoords();
      }
      
      public function get x() : int {
         return this._x;
      }
      
      public function set x(param1:int) : void {
         this._x = param1;
         this.setFromCoords();
      }
      
      public function get y() : int {
         return this._y;
      }
      
      public function set y(param1:int) : void {
         this._y = param1;
         this.setFromCoords();
      }
      
      public function add(param1:Point) : void {
         this._x = this._x + param1.x;
         this._y = this._y + param1.y;
         this.setFromCoords();
      }
      
      protected function setFromMapId() : void {
         this._worldId = (this._mapId & 1073479680) >> 18;
         this._x = this._mapId >> 9 & 511;
         this._y = this._mapId & 511;
         if((this._x & 256) == 256)
         {
            this._x = -(this._x & 255);
         }
         if((this._y & 256) == 256)
         {
            this._y = -(this._y & 255);
         }
      }
      
      protected function setFromCoords() : void {
         if(this._x > MAP_COORDS_MAX || this._y > MAP_COORDS_MAX || this._worldId > WORLD_ID_MAX)
         {
            throw new JerakineError("Coordinates or world identifier out of range.");
         }
         else
         {
            _loc1_ = this._worldId & 4095;
            _loc2_ = Math.abs(this._x) & 255;
            if(this._x < 0)
            {
               _loc2_ = _loc2_ | 256;
            }
            _loc3_ = Math.abs(this._y) & 255;
            if(this._y < 0)
            {
               _loc3_ = _loc3_ | 256;
            }
            this._mapId = _loc1_ << 18 | _loc2_ << 9 | _loc3_;
            return;
         }
      }
   }
}
