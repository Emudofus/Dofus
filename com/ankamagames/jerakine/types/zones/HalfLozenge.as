package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class HalfLozenge extends Object implements IZone
   {
      
      public function HalfLozenge(minRadius:uint, nRadius:uint, dataMapProvider:IDataMapProvider) {
         super();
         this.radius = nRadius;
         this._minRadius = minRadius;
         this._dataMapProvider = dataMapProvider;
      }
      
      protected static const _log:Logger;
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 2;
      
      private var _direction:uint = 6;
      
      private var _dataMapProvider:IDataMapProvider;
      
      public function get radius() : uint {
         return this._radius;
      }
      
      public function set radius(n:uint) : void {
         this._radius = n;
      }
      
      public function set minRadius(r:uint) : void {
         this._minRadius = r;
      }
      
      public function get minRadius() : uint {
         return this._minRadius;
      }
      
      public function set direction(d:uint) : void {
         this._direction = d;
      }
      
      public function get direction() : uint {
         return this._direction;
      }
      
      public function get surface() : uint {
         return this._radius * 2 + 1;
      }
      
      public function getCells(cellId:uint = 0) : Vector.<uint> {
         var i:* = 0;
         var j:* = 0;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._minRadius == 0)
         {
            aCells.push(cellId);
         }
         var inc:int = 1;
         var step:uint = 0;
         i = 1;
         while(i <= this._radius)
         {
            switch(this._direction)
            {
               case DirectionsEnum.UP_LEFT:
                  this.addCell(x + i,y + i,aCells);
                  this.addCell(x + i,y - i,aCells);
                  break;
               case DirectionsEnum.UP_RIGHT:
                  this.addCell(x - i,y - i,aCells);
                  this.addCell(x + i,y - i,aCells);
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  this.addCell(x - i,y + i,aCells);
                  this.addCell(x - i,y - i,aCells);
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  this.addCell(x - i,y + i,aCells);
                  this.addCell(x + i,y + i,aCells);
                  break;
            }
            i++;
         }
         return aCells;
      }
      
      private function addCell(x:int, y:int, cellMap:Vector.<uint>) : void {
         if((this._dataMapProvider == null) || (this._dataMapProvider.pointMov(x,y)))
         {
            cellMap.push(MapPoint.fromCoords(x,y).cellId);
         }
      }
   }
}
