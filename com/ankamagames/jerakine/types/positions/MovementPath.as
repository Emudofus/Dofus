package com.ankamagames.jerakine.types.positions
{
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
      
      public function set start(nValue:MapPoint) : void {
         this._oStart = nValue;
      }
      
      public function get end() : MapPoint {
         return this._oEnd;
      }
      
      public function set end(nValue:MapPoint) : void {
         this._oEnd = nValue;
      }
      
      public function get path() : Array {
         return this._aPath;
      }
      
      public function get length() : uint {
         return this._aPath.length;
      }
      
      public function fillFromCellIds(cells:Vector.<uint>) : void {
         var i:uint = 0;
         while(i < cells.length)
         {
            this._aPath.push(new PathElement(MapPoint.fromCellId(cells[i])));
            i++;
         }
         i = 0;
         while(i < cells.length - 1)
         {
            PathElement(this._aPath[i]).orientation = PathElement(this._aPath[i]).step.orientationTo(PathElement(this._aPath[i + 1]).step);
            i++;
         }
         if(this._aPath[0])
         {
            this._oStart = this._aPath[0].step;
            this._oEnd = this._aPath[this._aPath.length - 1].step;
         }
      }
      
      public function addPoint(pathElem:PathElement) : void {
         this._aPath.push(pathElem);
      }
      
      public function getPointAtIndex(index:uint) : PathElement {
         return this._aPath[index];
      }
      
      public function deletePoint(index:uint, deleteCount:uint = 1) : void {
         if(deleteCount == 0)
         {
            this._aPath.splice(index);
         }
         else
         {
            this._aPath.splice(index,deleteCount);
         }
      }
      
      public function toString() : String {
         var str:String = "\ndepart : [" + this._oStart.x + ", " + this._oStart.y + "]";
         str = str + ("\narrivée : [" + this._oEnd.x + ", " + this._oEnd.y + "]\nchemin :");
         var i:uint = 0;
         while(i < this._aPath.length)
         {
            str = str + ("[" + PathElement(this._aPath[i]).step.x + ", " + PathElement(this._aPath[i]).step.y + ", " + PathElement(this._aPath[i]).orientation + "]  ");
            i++;
         }
         return str;
      }
      
      public function compress() : void {
         var elem:uint = 0;
         if(this._aPath.length > 0)
         {
            elem = this._aPath.length - 1;
            while(elem > 0)
            {
               if(this._aPath[elem].orientation == this._aPath[elem - 1].orientation)
               {
                  this.deletePoint(elem);
                  elem--;
               }
               else
               {
                  elem--;
               }
            }
         }
      }
      
      public function fill() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function getCells() : Vector.<uint> {
         var mp:MapPoint = null;
         var cells:Vector.<uint> = new Vector.<uint>();
         var i:uint = 0;
         while(i < this._aPath.length)
         {
            mp = this._aPath[i].step;
            cells.push(mp.cellId);
            i++;
         }
         cells.push(this._oEnd.cellId);
         return cells;
      }
      
      public function replaceEnd(newEnd:MapPoint) : void {
         this._oEnd = newEnd;
      }
   }
}
