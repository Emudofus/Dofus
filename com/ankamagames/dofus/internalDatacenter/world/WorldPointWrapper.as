package com.ankamagames.dofus.internalDatacenter.world
{
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   
   public class WorldPointWrapper extends WorldPoint implements IDataCenter
   {
      
      public function WorldPointWrapper(param1:uint, param2:Boolean=false, param3:int=0, param4:int=0) {
         var _loc5_:Object = null;
         super();
         mapId = param1;
         setFromMapId();
         if(param2)
         {
            this._outdoorX = param3;
            this._outdoorY = param4;
         }
         else
         {
            _loc5_ = MapPosition.getMapPositionById(param1);
            if(!_loc5_)
            {
               this._outdoorX = x;
               this._outdoorY = y;
            }
            else
            {
               this._outdoorX = _loc5_.posX;
               this._outdoorY = _loc5_.posY;
            }
         }
      }
      
      public var outdoorMapId:uint;
      
      private var _outdoorX:int;
      
      private var _outdoorY:int;
      
      public function get outdoorX() : int {
         return this._outdoorX;
      }
      
      public function get outdoorY() : int {
         return this._outdoorY;
      }
      
      public function setOutdoorCoords(param1:int, param2:int) : void {
         this._outdoorX = param1;
         this._outdoorY = param2;
      }
   }
}
