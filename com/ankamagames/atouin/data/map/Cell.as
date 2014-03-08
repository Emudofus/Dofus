package com.ankamagames.atouin.data.map
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Point;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   
   public class Cell extends Object
   {
      
      public function Cell(param1:Layer) {
         super();
         this._layer = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cell));
      
      private static var _cellCoords:Point;
      
      public static function cellCoords(param1:uint) : Point {
         if(_cellCoords == null)
         {
            _cellCoords = new Point();
         }
         _cellCoords.x = param1 % AtouinConstants.MAP_WIDTH;
         _cellCoords.y = Math.floor(param1 / AtouinConstants.MAP_WIDTH);
         return _cellCoords;
      }
      
      public static function cellId(param1:Point) : uint {
         return CellIdConverter.coordToCellId(param1.x,param1.y);
      }
      
      public static function cellIdByXY(param1:int, param2:int) : uint {
         return CellIdConverter.coordToCellId(param1,param2);
      }
      
      public static function cellPixelCoords(param1:uint) : Point {
         var _loc2_:Point = cellCoords(param1);
         _loc2_.x = _loc2_.x * AtouinConstants.CELL_WIDTH + (_loc2_.y % 2 == 1?AtouinConstants.CELL_HALF_WIDTH:0);
         _loc2_.y = _loc2_.y * AtouinConstants.CELL_HALF_HEIGHT;
         return _loc2_;
      }
      
      public var cellId:int;
      
      public var elementsCount:int;
      
      public var elements:Array;
      
      private var _layer:Layer;
      
      public function get layer() : Layer {
         return this._layer;
      }
      
      public function get coords() : Point {
         return CellIdConverter.cellIdToCoord(this.cellId);
      }
      
      public function get pixelCoords() : Point {
         return cellPixelCoords(this.cellId);
      }
      
      public function fromRaw(param1:IDataInput, param2:int) : void {
         var be:BasicElement = null;
         var i:int = 0;
         var raw:IDataInput = param1;
         var mapVersion:int = param2;
         try
         {
            this.cellId = raw.readShort();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("    (Cell) Id : " + this.cellId);
            }
            this.elementsCount = raw.readShort();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("    (Cell) Elements count : " + this.elementsCount);
            }
            this.elements = new Array();
            i = 0;
            while(i < this.elementsCount)
            {
               be = BasicElement.getElementFromType(raw.readByte(),this);
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("    (Cell) Element at index " + i + " :");
               }
               be.fromRaw(raw,mapVersion);
               this.elements.push(be);
               i++;
            }
         }
         catch(e:*)
         {
            throw e;
         }
      }
   }
}
