package com.ankamagames.jerakine.types.positions
{
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   
   public class MovementPath extends Object
   {
      
      public function MovementPath() {
         super();
         this._oEnd = new MapPoint();
         this._oStart = new MapPoint();
         this._aPath = new Array();
      }
      
      public static var MAX_PATH_LENGTH:int = 100;
      
      protected var _oStart:MapPoint;
      
      protected var _oEnd:MapPoint;
      
      protected var _aPath:Array;
      
      public function get start() : MapPoint {
         return this._oStart;
      }
      
      public function set start(param1:MapPoint) : void {
         this._oStart = param1;
      }
      
      public function get end() : MapPoint {
         return this._oEnd;
      }
      
      public function set end(param1:MapPoint) : void {
         this._oEnd = param1;
      }
      
      public function get path() : Array {
         return this._aPath;
      }
      
      public function get length() : uint {
         return this._aPath.length;
      }
      
      public function fillFromCellIds(param1:Vector.<uint>) : void {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            this._aPath.push(new PathElement(MapPoint.fromCellId(param1[_loc2_])));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length-1)
         {
            PathElement(this._aPath[_loc2_]).orientation = PathElement(this._aPath[_loc2_]).step.orientationTo(PathElement(this._aPath[_loc2_ + 1]).step);
            _loc2_++;
         }
         if(this._aPath[0])
         {
            this._oStart = this._aPath[0].step;
            this._oEnd = this._aPath[this._aPath.length-1].step;
         }
      }
      
      public function addPoint(param1:PathElement) : void {
         this._aPath.push(param1);
      }
      
      public function getPointAtIndex(param1:uint) : PathElement {
         return this._aPath[param1];
      }
      
      public function deletePoint(param1:uint, param2:uint=1) : void {
         if(param2 == 0)
         {
            this._aPath.splice(param1);
         }
         else
         {
            this._aPath.splice(param1,param2);
         }
      }
      
      public function toString() : String {
         var _loc1_:* = "\ndepart : [" + this._oStart.x + ", " + this._oStart.y + "]";
         _loc1_ = _loc1_ + ("\narrivée : [" + this._oEnd.x + ", " + this._oEnd.y + "]\nchemin :");
         var _loc2_:uint = 0;
         while(_loc2_ < this._aPath.length)
         {
            _loc1_ = _loc1_ + ("[" + PathElement(this._aPath[_loc2_]).step.x + ", " + PathElement(this._aPath[_loc2_]).step.y + ", " + PathElement(this._aPath[_loc2_]).orientation + "]  ");
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function compress() : void {
         var _loc1_:uint = 0;
         if(this._aPath.length > 0)
         {
            _loc1_ = this._aPath.length-1;
            while(_loc1_ > 0)
            {
               if(this._aPath[_loc1_].orientation == this._aPath[_loc1_-1].orientation)
               {
                  this.deletePoint(_loc1_);
                  _loc1_--;
               }
               else
               {
                  _loc1_--;
               }
            }
         }
      }
      
      public function fill() : void {
         var _loc1_:* = 0;
         var _loc2_:PathElement = null;
         var _loc3_:PathElement = null;
         if(this._aPath.length > 0)
         {
            _loc1_ = 0;
            _loc2_ = new PathElement();
            _loc2_.orientation = 0;
            _loc2_.step = this._oEnd;
            this._aPath.push(_loc2_);
            while(_loc1_ < this._aPath.length-1)
            {
               if(Math.abs(this._aPath[_loc1_].step.x - this._aPath[_loc1_ + 1].step.x) > 1 || Math.abs(this._aPath[_loc1_].step.y - this._aPath[_loc1_ + 1].step.y) > 1)
               {
                  _loc3_ = new PathElement();
                  _loc3_.orientation = this._aPath[_loc1_].orientation;
                  switch(_loc3_.orientation)
                  {
                     case DirectionsEnum.RIGHT:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x + 1,this._aPath[_loc1_].step.y + 1);
                        break;
                     case DirectionsEnum.DOWN_RIGHT:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x + 1,this._aPath[_loc1_].step.y);
                        break;
                     case DirectionsEnum.DOWN:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x + 1,this._aPath[_loc1_].step.y-1);
                        break;
                     case DirectionsEnum.DOWN_LEFT:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x,this._aPath[_loc1_].step.y-1);
                        break;
                     case DirectionsEnum.LEFT:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x-1,this._aPath[_loc1_].step.y-1);
                        break;
                     case DirectionsEnum.UP_LEFT:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x-1,this._aPath[_loc1_].step.y);
                        break;
                     case DirectionsEnum.UP:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x-1,this._aPath[_loc1_].step.y + 1);
                        break;
                     case DirectionsEnum.UP_RIGHT:
                        _loc3_.step = MapPoint.fromCoords(this._aPath[_loc1_].step.x,this._aPath[_loc1_].step.y + 1);
                        break;
                  }
                  this._aPath.splice(_loc1_ + 1,0,_loc3_);
                  _loc1_++;
               }
               else
               {
                  _loc1_++;
               }
               if(_loc1_ > MAX_PATH_LENGTH)
               {
                  throw new JerakineError("Path too long. Maybe an orientation problem?");
               }
               else
               {
                  continue;
               }
            }
         }
         this._aPath.pop();
      }
      
      public function getCells() : Vector.<uint> {
         var _loc3_:MapPoint = null;
         var _loc1_:Vector.<uint> = new Vector.<uint>();
         var _loc2_:uint = 0;
         while(_loc2_ < this._aPath.length)
         {
            _loc3_ = this._aPath[_loc2_].step;
            _loc1_.push(_loc3_.cellId);
            _loc2_++;
         }
         _loc1_.push(this._oEnd.cellId);
         return _loc1_;
      }
      
      public function replaceEnd(param1:MapPoint) : void {
         this._oEnd = param1;
      }
   }
}
