package com.ankamagames.atouin.data.map
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.utils.IDataInput;

    public class CellData 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CellData));

        public var id:uint;
        public var speed:int;
        public var mapChangeData:uint;
        public var moveZone:uint;
        private var _losmov:int = 3;
        private var _floor:int;
        private var _map:Map;
        private var _arrow:int = 0;
        private var _mov:Boolean;
        private var _los:Boolean;
        private var _nonWalkableDuringFight:Boolean;
        private var _red:Boolean;
        private var _blue:Boolean;
        private var _farmCell:Boolean;
        private var _visible:Boolean;
        private var _nonWalkableDuringRP:Boolean;

        public function CellData(map:Map, cellId:uint)
        {
            this.id = cellId;
            this._map = map;
        }

        public function get map():Map
        {
            return (this._map);
        }

        public function get mov():Boolean
        {
            return (this._mov);
        }

        public function get los():Boolean
        {
            return (this._los);
        }

        public function get nonWalkableDuringFight():Boolean
        {
            return (this._nonWalkableDuringFight);
        }

        public function get red():Boolean
        {
            return (this._red);
        }

        public function get blue():Boolean
        {
            return (this._blue);
        }

        public function get farmCell():Boolean
        {
            return (this._farmCell);
        }

        public function get visible():Boolean
        {
            return (this._visible);
        }

        public function get nonWalkableDuringRP():Boolean
        {
            return (this._nonWalkableDuringRP);
        }

        public function get floor():int
        {
            return (this._floor);
        }

        public function get useTopArrow():Boolean
        {
            return (!(((this._arrow & 1) == 0)));
        }

        public function get useBottomArrow():Boolean
        {
            return (!(((this._arrow & 2) == 0)));
        }

        public function get useRightArrow():Boolean
        {
            return (!(((this._arrow & 4) == 0)));
        }

        public function get useLeftArrow():Boolean
        {
            return (!(((this._arrow & 8) == 0)));
        }

        public function fromRaw(raw:IDataInput):void
        {
            var tmpBits:int;
            try
            {
                this._floor = (raw.readByte() * 10);
                if (this._floor == -1280)
                {
                    return;
                };
                this._losmov = raw.readUnsignedByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (CellData) LOS+MOV : " + this._losmov));
                };
                this.speed = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (CellData) Speed : " + this.speed));
                };
                this.mapChangeData = raw.readUnsignedByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug(("  (CellData) MapChangeData : " + this.mapChangeData));
                };
                if (this._map.mapVersion > 5)
                {
                    this.moveZone = raw.readUnsignedByte();
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug(("  (CellData) moveZone : " + this.moveZone));
                    };
                };
                if (this._map.mapVersion > 7)
                {
                    tmpBits = raw.readByte();
                    this._arrow = (15 & tmpBits);
                    if (this.useTopArrow)
                    {
                        this._map.topArrowCell.push(this.id);
                    };
                    if (this.useBottomArrow)
                    {
                        this._map.bottomArrowCell.push(this.id);
                    };
                    if (this.useLeftArrow)
                    {
                        this._map.leftArrowCell.push(this.id);
                    };
                    if (this.useRightArrow)
                    {
                        this._map.rightArrowCell.push(this.id);
                    };
                };
            }
            catch(e)
            {
                throw (e);
            };
            this._los = (((this._losmov & 2) >> 1) == 1);
            this._mov = ((this._losmov & 1) == 1);
            this._visible = (((this._losmov & 64) >> 6) == 1);
            this._farmCell = (((this._losmov & 32) >> 5) == 1);
            this._blue = (((this._losmov & 16) >> 4) == 1);
            this._red = (((this._losmov & 8) >> 3) == 1);
            this._nonWalkableDuringRP = (((this._losmov & 128) >> 7) == 1);
            this._nonWalkableDuringFight = (((this._losmov & 4) >> 2) == 1);
        }


    }
}//package com.ankamagames.atouin.data.map

