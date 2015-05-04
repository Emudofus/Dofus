package com.ankamagames.dofus.internalDatacenter.world
{
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.dofus.datacenter.world.MapScrollAction;
   
   public class WorldPointWrapper extends WorldPoint implements IDataCenter
   {
      
      public function WorldPointWrapper(param1:uint, param2:Boolean = false, param3:int = 0, param4:int = 0)
      {
         var _loc7_:Object = null;
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
            _loc7_ = MapPosition.getMapPositionById(param1);
            if(!_loc7_)
            {
               this._outdoorX = x;
               this._outdoorY = y;
            }
            else
            {
               this._outdoorX = _loc7_.posX;
               this._outdoorY = _loc7_.posY;
            }
         }
         var _loc5_:DataMapContainer = MapDisplayManager.getInstance().getDataMapContainer();
         if((_loc5_) && (_loc5_.dataMap) && _loc5_.dataMap.id == param1)
         {
            this._topNeighbourId = _loc5_.dataMap.topNeighbourId;
            this._bottomNeighbourId = _loc5_.dataMap.bottomNeighbourId;
            this._leftNeighbourId = _loc5_.dataMap.leftNeighbourId;
            this._rightNeighbourId = _loc5_.dataMap.rightNeighbourId;
         }
         var _loc6_:MapScrollAction = MapScrollAction.getMapScrollActionById(param1);
         if(_loc6_)
         {
            if(_loc6_.topExists)
            {
               this._topNeighbourId = _loc6_.topMapId;
            }
            if(_loc6_.bottomExists)
            {
               this._bottomNeighbourId = _loc6_.bottomMapId;
            }
            if(_loc6_.leftExists)
            {
               this._leftNeighbourId = _loc6_.leftMapId;
            }
            if(_loc6_.rightExists)
            {
               this._rightNeighbourId = _loc6_.rightMapId;
            }
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldPointWrapper));
      
      public var outdoorMapId:uint;
      
      private var _outdoorX:int;
      
      private var _outdoorY:int;
      
      private var _topNeighbourId:int = -1;
      
      private var _bottomNeighbourId:int = -1;
      
      private var _leftNeighbourId:int = -1;
      
      private var _rightNeighbourId:int = -1;
      
      public function get outdoorX() : int
      {
         return this._outdoorX;
      }
      
      public function get outdoorY() : int
      {
         return this._outdoorY;
      }
      
      public function get topNeighbourId() : int
      {
         return this._topNeighbourId;
      }
      
      public function get bottomNeighbourId() : int
      {
         return this._bottomNeighbourId;
      }
      
      public function get leftNeighbourId() : int
      {
         return this._leftNeighbourId;
      }
      
      public function get rightNeighbourId() : int
      {
         return this._rightNeighbourId;
      }
      
      public function setOutdoorCoords(param1:int, param2:int) : void
      {
         this._outdoorX = param1;
         this._outdoorY = param2;
      }
   }
}
