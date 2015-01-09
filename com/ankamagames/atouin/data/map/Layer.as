package com.ankamagames.atouin.data.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.utils.IDataInput;

    public class Layer 
    {

        public static const LAYER_GROUND:uint = 0;
        public static const LAYER_ADDITIONAL_GROUND:uint = 1;
        public static const LAYER_DECOR:uint = 2;
        public static const LAYER_ADDITIONAL_DECOR:uint = 3;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Layer));

        public var layerId:int;
        public var refCell:int = 0;
        public var cellsCount:int;
        public var cells:Array;
        private var _map:Map;

        public function Layer(map:Map)
        {
            this._map = map;
        }

        public function get map():Map
        {
            return (this._map);
        }

        public function fromRaw(raw:IDataInput, mapVersion:int):void
        {
            var i:int;
            var c:Cell;
            try
            {
                this.layerId = raw.readInt();
                this.cellsCount = raw.readShort();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (Layer) Cells count : " + this.cellsCount));
                };
                this.cells = new Array();
                i = 0;
                while (i < this.cellsCount)
                {
                    c = new Cell(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug((("  (Layer) Cell at index " + i) + " :"));
                    };
                    c.fromRaw(raw, mapVersion);
                    this.cells.push(c);
                    i = (i + 1);
                };
            }
            catch(e)
            {
                throw (e);
            };
        }


    }
}//package com.ankamagames.atouin.data.map

