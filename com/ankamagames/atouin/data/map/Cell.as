package com.ankamagames.atouin.data.map
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.elements.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Cell extends Object
    {
        public var cellId:int;
        public var elementsCount:int;
        public var elements:Array;
        private var _layer:Layer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Cell));
        private static var _cellCoords:Point;

        public function Cell(param1:Layer)
        {
            this._layer = param1;
            return;
        }// end function

        public function get layer() : Layer
        {
            return this._layer;
        }// end function

        public function get coords() : Point
        {
            return CellIdConverter.cellIdToCoord(this.cellId);
        }// end function

        public function get pixelCoords() : Point
        {
            return cellPixelCoords(this.cellId);
        }// end function

        public function fromRaw(param1:IDataInput, param2:int) : void
        {
            var be:BasicElement;
            var i:int;
            var raw:* = param1;
            var mapVersion:* = param2;
            try
            {
                this.cellId = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("    (Cell) Id : " + this.cellId);
                }
                this.elementsCount = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("    (Cell) Elements count : " + this.elementsCount);
                }
                this.elements = new Array();
                i;
                while (i < this.elementsCount)
                {
                    
                    be = BasicElement.getElementFromType(raw.readByte(), this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("    (Cell) Element at index " + i + " :");
                    }
                    be.fromRaw(raw, mapVersion);
                    this.elements.push(be);
                    i = (i + 1);
                }
            }
            catch (e)
            {
                throw e;
            }
            return;
        }// end function

        public static function cellCoords(param1:uint) : Point
        {
            if (_cellCoords == null)
            {
                _cellCoords = new Point();
            }
            _cellCoords.x = param1 % AtouinConstants.MAP_WIDTH;
            _cellCoords.y = Math.floor(param1 / AtouinConstants.MAP_WIDTH);
            return _cellCoords;
        }// end function

        public static function cellId(param1:Point) : uint
        {
            return CellIdConverter.coordToCellId(param1.x, param1.y);
        }// end function

        public static function cellIdByXY(param1:int, param2:int) : uint
        {
            return CellIdConverter.coordToCellId(param1, param2);
        }// end function

        public static function cellPixelCoords(param1:uint) : Point
        {
            var _loc_2:* = cellCoords(param1);
            _loc_2.x = _loc_2.x * AtouinConstants.CELL_WIDTH + (_loc_2.y % 2 == 1 ? (AtouinConstants.CELL_HALF_WIDTH) : (0));
            _loc_2.y = _loc_2.y * AtouinConstants.CELL_HALF_HEIGHT;
            return _loc_2;
        }// end function

    }
}
