package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class Lozenge extends Object implements IZone
   {
      
      public function Lozenge(nMinRadius:uint, nRadius:uint, dataMapProvider:IDataMapProvider) {
         super();
         this.radius = nRadius;
         this.minRadius = nMinRadius;
         this._dataMapProvider = dataMapProvider;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Lozenge));
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 2;
      
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
      }
      
      public function get direction() : uint {
         return null;
      }
      
      public function get surface() : uint {
         return Math.pow(this._radius + 1,2) + Math.pow(this._radius,2);
      }
      
      public function getCells(cellId:uint=0) : Vector.<uint> {
         var i:* = 0;
         var j:* = 0;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if(this._radius == 0)
         {
            if(this._minRadius == 0)
            {
               aCells.push(cellId);
            }
            return aCells;
         }
         var inc:int = 1;
         var step:uint = 0;
         i = x - this._radius;
         while(i <= x + this._radius)
         {
            j = -step;
            while(j <= step)
            {
               if((!this._minRadius) || (Math.abs(x - i) + Math.abs(j) >= this._minRadius))
               {
                  if(MapPoint.isInMap(i,j + y))
                  {
                     this.addCell(i,j + y,aCells);
                  }
               }
               j++;
            }
            if(step == this._radius)
            {
               inc = -inc;
            }
            step = step + inc;
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
