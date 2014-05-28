package com.ankamagames.jerakine.types.positions
{
   import flash.geom.Point;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   
   public class MapPoint extends Object
   {
      
      public function MapPoint() {
         super();
      }
      
      private static const VECTOR_RIGHT:Point;
      
      private static const VECTOR_DOWN_RIGHT:Point;
      
      private static const VECTOR_DOWN:Point;
      
      private static const VECTOR_DOWN_LEFT:Point;
      
      private static const VECTOR_LEFT:Point;
      
      private static const VECTOR_UP_LEFT:Point;
      
      private static const VECTOR_UP:Point;
      
      private static const VECTOR_UP_RIGHT:Point;
      
      public static const MAP_WIDTH:uint = 14;
      
      public static const MAP_HEIGHT:uint = 20;
      
      private static var _bInit:Boolean = false;
      
      public static var CELLPOS:Array;
      
      public static function fromCellId(cellId:uint) : MapPoint {
         var mp:MapPoint = new MapPoint();
         mp._nCellId = cellId;
         mp.setFromCellId();
         return mp;
      }
      
      public static function fromCoords(x:int, y:int) : MapPoint {
         var mp:MapPoint = new MapPoint();
         mp._nX = x;
         mp._nY = y;
         mp.setFromCoords();
         return mp;
      }
      
      public static function getOrientationsDistance(currentOrientation:int, defaultOrientation:int) : int {
         return Math.min(Math.abs(defaultOrientation - currentOrientation),Math.abs(8 - defaultOrientation + currentOrientation));
      }
      
      public static function isInMap(x:int, y:int) : Boolean {
         return (x + y >= 0) && (x - y >= 0) && (x - y < MAP_HEIGHT * 2) && (x + y < MAP_WIDTH * 2);
      }
      
      private static function init() : void {
         var b:* = 0;
         _bInit = true;
         var startX:int = 0;
         var startY:int = 0;
         var cell:int = 0;
         var a:int = 0;
         while(a < MAP_HEIGHT)
         {
            b = 0;
            while(b < MAP_WIDTH)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
               b++;
            }
            startX++;
            b = 0;
            while(b < MAP_WIDTH)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
               b++;
            }
            startY--;
            a++;
         }
      }
      
      private var _nCellId:uint;
      
      private var _nX:int;
      
      private var _nY:int;
      
      public function get cellId() : uint {
         return this._nCellId;
      }
      
      public function set cellId(nValue:uint) : void {
         this._nCellId = nValue;
         this.setFromCellId();
      }
      
      public function get x() : int {
         return this._nX;
      }
      
      public function set x(nValue:int) : void {
         this._nX = nValue;
         this.setFromCoords();
      }
      
      public function get y() : int {
         return this._nY;
      }
      
      public function set y(nValue:int) : void {
         this._nY = nValue;
         this.setFromCoords();
      }
      
      public function distanceTo(mp:MapPoint) : uint {
         return Math.sqrt(Math.pow(mp.x - this.x,2) + Math.pow(mp.y - this.y,2));
      }
      
      public function distanceToCell(cell:MapPoint) : int {
         return Math.abs(this.x - cell.x) + Math.abs(this.y - cell.y);
      }
      
      public function orientationTo(mp:MapPoint) : uint {
         var result:uint = 0;
         if((this.x == mp.x) && (this.y == mp.y))
         {
            return 1;
         }
         var pt:Point = new Point();
         pt.x = mp.x > this.x?1:mp.x < this.x?-1:0;
         pt.y = mp.y > this.y?1:mp.y < this.y?-1:0;
         if((pt.x == VECTOR_RIGHT.x) && (pt.y == VECTOR_RIGHT.y))
         {
            result = DirectionsEnum.RIGHT;
         }
         else if((pt.x == VECTOR_DOWN_RIGHT.x) && (pt.y == VECTOR_DOWN_RIGHT.y))
         {
            result = DirectionsEnum.DOWN_RIGHT;
         }
         else if((pt.x == VECTOR_DOWN.x) && (pt.y == VECTOR_DOWN.y))
         {
            result = DirectionsEnum.DOWN;
         }
         else if((pt.x == VECTOR_DOWN_LEFT.x) && (pt.y == VECTOR_DOWN_LEFT.y))
         {
            result = DirectionsEnum.DOWN_LEFT;
         }
         else if((pt.x == VECTOR_LEFT.x) && (pt.y == VECTOR_LEFT.y))
         {
            result = DirectionsEnum.LEFT;
         }
         else if((pt.x == VECTOR_UP_LEFT.x) && (pt.y == VECTOR_UP_LEFT.y))
         {
            result = DirectionsEnum.UP_LEFT;
         }
         else if((pt.x == VECTOR_UP.x) && (pt.y == VECTOR_UP.y))
         {
            result = DirectionsEnum.UP;
         }
         else if((pt.x == VECTOR_UP_RIGHT.x) && (pt.y == VECTOR_UP_RIGHT.y))
         {
            result = DirectionsEnum.UP_RIGHT;
         }
         
         
         
         
         
         
         
         return result;
      }
      
      public function advancedOrientationTo(mp:MapPoint, fourDir:Boolean = true) : uint {
         if(!mp)
         {
            return 0;
         }
         var ac:int = mp.x - this.x;
         var bc:int = this.y - mp.y;
         var angle:int = Math.acos(ac / Math.sqrt(Math.pow(ac,2) + Math.pow(bc,2))) * 180 / Math.PI * (mp.y > this.y?-1:1);
         if(fourDir)
         {
            angle = Math.round(angle / 90) * 2 + 1;
         }
         else
         {
            angle = Math.round(angle / 45) + 1;
         }
         if(angle < 0)
         {
            angle = angle + 8;
         }
         return angle;
      }
      
      public function getNearestFreeCell(mapProvider:IDataMapProvider, allowThoughEntity:Boolean = true) : MapPoint {
         var mp:MapPoint = null;
         var i:uint = 0;
         while(i < 8)
         {
            mp = this.getNearestFreeCellInDirection(i,mapProvider,false,allowThoughEntity);
            if(mp)
            {
               break;
            }
            i++;
         }
         return mp;
      }
      
      public function getNearestCellInDirection(orientation:uint) : MapPoint {
         var mp:MapPoint = null;
         switch(orientation)
         {
            case 0:
               mp = MapPoint.fromCoords(this._nX + 1,this._nY + 1);
               break;
            case 1:
               mp = MapPoint.fromCoords(this._nX + 1,this._nY);
               break;
            case 2:
               mp = MapPoint.fromCoords(this._nX + 1,this._nY - 1);
               break;
            case 3:
               mp = MapPoint.fromCoords(this._nX,this._nY - 1);
               break;
            case 4:
               mp = MapPoint.fromCoords(this._nX - 1,this._nY - 1);
               break;
            case 5:
               mp = MapPoint.fromCoords(this._nX - 1,this._nY);
               break;
            case 6:
               mp = MapPoint.fromCoords(this._nX - 1,this._nY + 1);
               break;
            case 7:
               mp = MapPoint.fromCoords(this._nX,this._nY + 1);
               break;
         }
         if(MapPoint.isInMap(mp._nX,mp._nY))
         {
            return mp;
         }
         return null;
      }
      
      public function getNearestFreeCellInDirection(orientation:uint, mapProvider:IDataMapProvider, allowItself:Boolean = true, allowThoughEntity:Boolean = true, forbidenCellsId:Array = null) : MapPoint {
         var i:* = 0;
         var speed:* = 0;
         var weight:* = 0;
         var mp:MapPoint = null;
         if(forbidenCellsId == null)
         {
            forbidenCellsId = new Array();
         }
         var cells:Vector.<MapPoint> = new Vector.<MapPoint>(8,true);
         var weights:Vector.<int> = new Vector.<int>(8,true);
         i = 0;
         while(i < 8)
         {
            mp = this.getNearestCellInDirection(i);
            if((!(mp == null)) && (forbidenCellsId.indexOf(mp.cellId) == -1))
            {
               speed = mapProvider.getCellSpeed(mp.cellId);
               if(!mapProvider.pointMov(mp._nX,mp._nY,allowThoughEntity,this.cellId))
               {
                  speed = -100;
               }
               weights[i] = getOrientationsDistance(i,orientation) + (speed >= 0?5 - speed:11 + Math.abs(speed));
            }
            else
            {
               weights[i] = 1000;
            }
            cells[i] = mp;
            i++;
         }
         mp = null;
         var minWeightOrientation:int = 0;
         var minWeight:int = weights[0];
         i = 1;
         while(i < 8)
         {
            weight = weights[i];
            if((weight < minWeight) && (!(cells[i] == null)))
            {
               minWeight = weight;
               minWeightOrientation = i;
            }
            i++;
         }
         mp = cells[minWeightOrientation];
         if((mp == null) && (allowItself) && (mapProvider.pointMov(this._nX,this._nY,allowThoughEntity,this.cellId)))
         {
            return this;
         }
         return mp;
      }
      
      public function equals(mp:MapPoint) : Boolean {
         return mp.cellId == this.cellId;
      }
      
      public function toString() : String {
         return "[MapPoint(x:" + this._nX + ", y:" + this._nY + ", id:" + this._nCellId + ")]";
      }
      
      private function setFromCoords() : void {
         if(!_bInit)
         {
            init();
         }
         this._nCellId = (this._nX - this._nY) * MAP_WIDTH + this._nY + (this._nX - this._nY) / 2;
      }
      
      private function setFromCellId() : void {
         if(!_bInit)
         {
            init();
         }
         if(!CELLPOS[this._nCellId])
         {
            throw new JerakineError("Cell identifier out of bounds (" + this._nCellId + ").");
         }
         else
         {
            p = CELLPOS[this._nCellId];
            this._nX = p.x;
            this._nY = p.y;
            return;
         }
      }
   }
}
