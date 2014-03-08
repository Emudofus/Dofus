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
      
      public function Cell(layer:Layer) {
         super();
         this._layer = layer;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cell));
      
      private static var _cellCoords:Point;
      
      public static function cellCoords(cellId:uint) : Point {
         if(_cellCoords == null)
         {
            _cellCoords = new Point();
         }
         _cellCoords.x = cellId % AtouinConstants.MAP_WIDTH;
         _cellCoords.y = Math.floor(cellId / AtouinConstants.MAP_WIDTH);
         return _cellCoords;
      }
      
      public static function cellId(p:Point) : uint {
         return CellIdConverter.coordToCellId(p.x,p.y);
      }
      
      public static function cellIdByXY(x:int, y:int) : uint {
         return CellIdConverter.coordToCellId(x,y);
      }
      
      public static function cellPixelCoords(cellId:uint) : Point {
         var p:Point = cellCoords(cellId);
         p.x = p.x * AtouinConstants.CELL_WIDTH + (p.y % 2 == 1?AtouinConstants.CELL_HALF_WIDTH:0);
         p.y = p.y * AtouinConstants.CELL_HALF_HEIGHT;
         return p;
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
      
      public function fromRaw(raw:IDataInput, mapVersion:int) : void {
         var be:BasicElement = null;
         var i:int = 0;
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
