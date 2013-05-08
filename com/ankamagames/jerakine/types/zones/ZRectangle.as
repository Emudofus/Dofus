package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MapPoint;


   public class ZRectangle extends Object implements IZone
   {
         

      public function ZRectangle(nMinRadius:uint, nWidth:uint, nHeight:uint, dataMapProvider:IDataMapProvider) {
         super();
         this.radius=nWidth;
         this._radius2=nHeight?nHeight:nWidth;
         this.minRadius=nMinRadius;
         this._dataMapProvider=dataMapProvider;
      }



      private var _radius:uint = 0;

      private var _radius2:uint;

      private var _minRadius:uint = 2;

      private var _dataMapProvider:IDataMapProvider;

      private var _diagonalFree:Boolean = false;

      public function get radius() : uint {
         return this._radius;
      }

      public function set radius(n:uint) : void {
         this._radius=n;
      }

      public function set minRadius(r:uint) : void {
         this._minRadius=r;
      }

      public function get minRadius() : uint {
         return this._minRadius;
      }

      public function set direction(d:uint) : void {
         
      }

      public function get direction() : uint {
         return null;
      }

      public function set diagonalFree(d:Boolean) : void {
         this._diagonalFree=d;
      }

      public function get diagonalFree() : Boolean {
         return this._diagonalFree;
      }

      public function get surface() : uint {
         return Math.pow(this._radius+this._radius2+1,2);
      }

      public function getCells(cellId:uint=0) : Vector.<uint> {
         var i:* = 0;
         var j:* = 0;
         var aCells:Vector.<uint> = new Vector.<uint>();
         var origin:MapPoint = MapPoint.fromCellId(cellId);
         var x:int = origin.x;
         var y:int = origin.y;
         if((this._radius==0)||(this._radius2==0))
         {
            if((this._minRadius==0)&&(!this._diagonalFree))
            {
               aCells.push(cellId);
            }
            return aCells;
         }
         i=x-this._radius;
         while(i<=x+this._radius)
         {
            j=y-this._radius2;
            while(j<=y+this._radius2)
            {
               if((!this._minRadius)||(Math.abs(x-i)+Math.abs(y-j)>=this._minRadius))
               {
                  if((!this._diagonalFree)||(!(Math.abs(x-i)==Math.abs(y-j))))
                  {
                     if(MapPoint.isInMap(i,j))
                     {
                        this.addCell(i,j,aCells);
                     }
                  }
               }
               j++;
            }
            i++;
         }
         return aCells;
      }

      private function addCell(x:int, y:int, cellMap:Vector.<uint>) : void {
         if((this._dataMapProvider==null)||(this._dataMapProvider.pointMov(x,y)))
         {
            cellMap.push(MapPoint.fromCoords(x,y).cellId);
         }
      }
   }

}