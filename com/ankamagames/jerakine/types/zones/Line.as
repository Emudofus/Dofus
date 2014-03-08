package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class Line extends Object implements IZone
   {
      
      public function Line(nRadius:uint, dataMapProvider:IDataMapProvider) {
         super();
         this.radius = nRadius;
         this._dataMapProvider = dataMapProvider;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Line));
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _nDirection:uint = 1;
      
      private var _dataMapProvider:IDataMapProvider;
      
      public function get radius() : uint {
         return this._radius;
      }
      
      public function set radius(n:uint) : void {
         this._radius = n;
      }
      
      public function get surface() : uint {
         return this._radius + 1;
      }
      
      public function set minRadius(r:uint) : void {
         this._minRadius = r;
      }
      
      public function get minRadius() : uint {
         return this._minRadius;
      }
      
      public function set direction(d:uint) : void {
         this._nDirection = d;
      }
      
      public function get direction() : uint {
         return this._nDirection;
      }
      
      public function getCells(cellId:uint=0) : Vector.<uint> {
         var added:* = false;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         var r:int = this._minRadius;
         while(r <= this._radius)
         {
            switch(this._nDirection)
            {
               case DirectionsEnum.LEFT:
                  if(MapPoint.isInMap(x - r,y - r))
                  {
                     added = this.addCell(x - r,y - r,aCells);
                  }
                  break;
               case DirectionsEnum.UP:
                  if(MapPoint.isInMap(x - r,y + r))
                  {
                     added = this.addCell(x - r,y + r,aCells);
                  }
                  break;
               case DirectionsEnum.RIGHT:
                  if(MapPoint.isInMap(x + r,y + r))
                  {
                     added = this.addCell(x + r,y + r,aCells);
                  }
                  break;
               case DirectionsEnum.DOWN:
                  if(MapPoint.isInMap(x + r,y - r))
                  {
                     added = this.addCell(x + r,y - r,aCells);
                  }
                  break;
               case DirectionsEnum.UP_LEFT:
                  if(MapPoint.isInMap(x - r,y))
                  {
                     added = this.addCell(x - r,y,aCells);
                  }
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  if(MapPoint.isInMap(x,y - r))
                  {
                     added = this.addCell(x,y - r,aCells);
                  }
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  if(MapPoint.isInMap(x + r,y))
                  {
                     added = this.addCell(x + r,y,aCells);
                  }
                  break;
               case DirectionsEnum.UP_RIGHT:
                  if(MapPoint.isInMap(x,y + r))
                  {
                     added = this.addCell(x,y + r,aCells);
                  }
                  break;
            }
            if(!added)
            {
               break;
            }
            r++;
         }
         return aCells;
      }
      
      private function addCell(x:int, y:int, cellMap:Vector.<uint>) : Boolean {
         if((this._dataMapProvider == null) || (this._dataMapProvider.pointMov(x,y)))
         {
            cellMap.push(MapPoint.fromCoords(x,y).cellId);
            return true;
         }
         return false;
      }
   }
}
