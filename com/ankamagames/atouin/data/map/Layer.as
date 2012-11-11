package com.ankamagames.atouin.data.map
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Layer extends Object
    {
        public var layerId:int;
        public var refCell:int = 0;
        public var cellsCount:int;
        public var cells:Array;
        private var _map:Map;
        public static const LAYER_GROUND:uint = 0;
        public static const LAYER_ADDITIONAL_GROUND:uint = 1;
        public static const LAYER_DECOR:uint = 2;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Layer));

        public function Layer(param1:Map)
        {
            this._map = param1;
            return;
        }// end function

        public function get map() : Map
        {
            return this._map;
        }// end function

        public function fromRaw(param1:IDataInput, param2:int) : void
        {
            var i:int;
            var c:Cell;
            var raw:* = param1;
            var mapVersion:* = param2;
            try
            {
                this.layerId = raw.readInt();
                this.cellsCount = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (Layer) Cells count : " + this.cellsCount);
                }
                this.cells = new Array();
                i;
                while (i < this.cellsCount)
                {
                    
                    c = new Cell(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("  (Layer) Cell at index " + i + " :");
                    }
                    c.fromRaw(raw, mapVersion);
                    this.cells.push(c);
                    i = (i + 1);
                }
            }
            catch (e)
            {
                throw e;
            }
            return;
        }// end function

    }
}
