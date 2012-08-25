package com.ankamagames.atouin.data.map
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.*;
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.atouin.data.elements.subtypes.*;
    import com.ankamagames.atouin.data.map.elements.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.errors.*;
    import flash.utils.*;

    public class Map extends Object
    {
        public var mapClass:Class;
        public var mapVersion:int;
        public var encrypted:Boolean;
        public var encryptionVersion:uint;
        public var groundCRC:int;
        public var zoomScale:Number = 1;
        public var zoomOffsetX:int;
        public var zoomOffsetY:int;
        public var groundCacheCurrentlyUsed:int = 0;
        public var id:int;
        public var relativeId:int;
        public var mapType:int;
        public var backgroundsCount:int;
        public var backgroundFixtures:Array;
        public var foregroundsCount:int;
        public var foregroundFixtures:Array;
        public var subareaId:int;
        public var shadowBonusOnEntities:int;
        public var backgroundColor:uint;
        public var backgroundRed:int;
        public var backgroundGreen:int;
        public var backgroundBlue:int;
        public var topNeighbourId:int;
        public var bottomNeighbourId:int;
        public var leftNeighbourId:int;
        public var rightNeighbourId:int;
        public var useLowPassFilter:Boolean;
        public var useReverb:Boolean;
        public var presetId:int;
        public var cellsCount:int;
        public var layersCount:int;
        public var layers:Array;
        public var cells:Array;
        private var _parsed:Boolean;
        private var _failed:Boolean;
        private var _gfxList:Array;
        private var _gfxCount:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Map));

        public function Map()
        {
            this.mapClass = Map;
            return;
        }// end function

        public function get parsed() : Boolean
        {
            return this._parsed;
        }// end function

        public function get failed() : Boolean
        {
            return this._failed;
        }// end function

        public function getGfxList(param1:Boolean = false) : Array
        {
            if (!this._gfxList)
            {
                this.computeGfxList(param1);
            }
            return this._gfxList;
        }// end function

        public function getGfxCount(param1:uint) : uint
        {
            if (!this._gfxList)
            {
                this.computeGfxList();
            }
            return this._gfxCount[param1];
        }// end function

        public function fromRaw(param1:IDataInput, param2:ByteArray = null) : void
        {
            var header:int;
            var i:int;
            var j:int;
            var k:int;
            var l:int;
            var dataLen:uint;
            var encryptedData:ByteArray;
            var ind:uint;
            var bg:Fixture;
            var fg:Fixture;
            var la:Layer;
            var cd:CellData;
            var raw:* = param1;
            var decryptionKey:* = param2;
            try
            {
                header = raw.readByte();
                if (header != 77)
                {
                    throw new DataFormatError("Unknown file format");
                }
                this.mapVersion = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Map version : " + this.mapVersion);
                }
                this.id = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Map id : " + this.id);
                }
                if (this.mapVersion >= 7)
                {
                    this.encrypted = raw.readBoolean();
                    this.encryptionVersion = raw.readByte();
                    dataLen = raw.readInt();
                    if (this.encrypted)
                    {
                        if (!decryptionKey)
                        {
                            throw new IllegalOperationError("Map decryption key is empty");
                        }
                        encryptedData = new ByteArray();
                        raw.readBytes(encryptedData, 0, dataLen);
                        ind;
                        while (ind < encryptedData.length)
                        {
                            
                            encryptedData[ind] = encryptedData[ind] ^ decryptionKey[ind % decryptionKey.length];
                            ind = (ind + 1);
                        }
                        encryptedData.position = 0;
                        raw = encryptedData;
                    }
                }
                this.relativeId = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Map relativeId: " + this.relativeId);
                }
                this.mapType = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Map type : " + this.mapType);
                }
                this.subareaId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Subarea id : " + this.subareaId);
                }
                this.topNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("topNeighbourId : " + this.topNeighbourId);
                }
                this.bottomNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("bottomNeighbourId : " + this.bottomNeighbourId);
                }
                this.leftNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("leftNeighbourId : " + this.leftNeighbourId);
                }
                this.rightNeighbourId = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("rightNeighbourId : " + this.rightNeighbourId);
                }
                this.shadowBonusOnEntities = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("ShadowBonusOnEntities : " + this.shadowBonusOnEntities);
                }
                if (this.mapVersion >= 3)
                {
                    this.backgroundRed = raw.readByte();
                    this.backgroundGreen = raw.readByte();
                    this.backgroundBlue = raw.readByte();
                    this.backgroundColor = (this.backgroundRed & 255) << 16 | (this.backgroundGreen & 255) << 8 | this.backgroundBlue & 255;
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("BackgroundColor : " + this.backgroundRed + "," + this.backgroundGreen + "," + this.backgroundBlue);
                    }
                }
                if (this.mapVersion >= 4)
                {
                    this.zoomScale = raw.readUnsignedShort() / 100;
                    this.zoomOffsetX = raw.readShort();
                    this.zoomOffsetY = raw.readShort();
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Zoom auto : " + this.zoomScale + "," + this.zoomOffsetX + "," + this.zoomOffsetY);
                    }
                }
                this.useLowPassFilter = raw.readByte() == 1;
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("useLowPassFilter : " + this.useLowPassFilter);
                }
                this.useReverb = raw.readByte() == 1;
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("useReverb : " + this.useReverb);
                }
                if (this.useReverb)
                {
                    this.presetId = raw.readInt();
                }
                else
                {
                    this.presetId = -1;
                }
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("presetId : " + this.presetId);
                }
                this.backgroundsCount = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Backgrounds count : " + this.backgroundsCount);
                }
                this.backgroundFixtures = new Array();
                i;
                while (i < this.backgroundsCount)
                {
                    
                    bg = new Fixture(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Background at index " + i + " :");
                    }
                    bg.fromRaw(raw);
                    this.backgroundFixtures.push(bg);
                    i = (i + 1);
                }
                this.foregroundsCount = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Foregrounds count : " + this.foregroundsCount);
                }
                this.foregroundFixtures = new Array();
                j;
                while (j < this.foregroundsCount)
                {
                    
                    fg = new Fixture(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Foreground at index " + j + " :");
                    }
                    fg.fromRaw(raw);
                    this.foregroundFixtures.push(fg);
                    j = (j + 1);
                }
                this.cellsCount = AtouinConstants.MAP_CELLS_COUNT;
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Cells count : " + this.cellsCount);
                }
                raw.readInt();
                this.groundCRC = raw.readInt();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("groundCRC : " + this.groundCRC);
                }
                this.layersCount = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("Layers count : " + this.layersCount);
                }
                this.layers = new Array();
                k;
                while (k < this.layersCount)
                {
                    
                    la = new Layer(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Layer at index " + k + " :");
                    }
                    la.fromRaw(raw, this.mapVersion);
                    this.layers.push(la);
                    k = (k + 1);
                }
                this.cells = new Array();
                l;
                while (l < this.cellsCount)
                {
                    
                    cd = new CellData(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Cell data at index " + l + " :");
                    }
                    cd.fromRaw(raw);
                    this.cells.push(cd);
                    l = (l + 1);
                }
                this._parsed = true;
            }
            catch (e)
            {
                _failed = true;
                throw e;
            }
            return;
        }// end function

        private function computeGfxList(param1:Boolean = false) : void
        {
            var _loc_6:String = null;
            var _loc_7:Layer = null;
            var _loc_8:Array = null;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:Cell = null;
            var _loc_12:Array = null;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:BasicElement = null;
            var _loc_16:int = 0;
            var _loc_17:GraphicalElementData = null;
            var _loc_18:NormalGraphicalElementData = null;
            var _loc_2:* = Elements.getInstance();
            var _loc_3:* = new Array();
            this._gfxCount = new Array();
            var _loc_4:* = this.layers.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = this.layers[_loc_5];
                if (param1 && _loc_5 == 0)
                {
                }
                else
                {
                    _loc_8 = _loc_7.cells;
                    _loc_9 = _loc_8.length;
                    _loc_10 = 0;
                    while (_loc_10 < _loc_9)
                    {
                        
                        _loc_11 = _loc_8[_loc_10];
                        _loc_12 = _loc_11.elements;
                        _loc_13 = _loc_12.length;
                        _loc_14 = 0;
                        while (_loc_14 < _loc_13)
                        {
                            
                            _loc_15 = _loc_12[_loc_14];
                            if (_loc_15.elementType == ElementTypesEnum.GRAPHICAL)
                            {
                                _loc_16 = GraphicalElement(_loc_15).elementId;
                                _loc_17 = _loc_2.getElementData(_loc_16);
                                if (_loc_17 == null)
                                {
                                    _log.error("Unknown graphical element ID " + _loc_16);
                                    ;
                                }
                                else if (_loc_17 is NormalGraphicalElementData)
                                {
                                    _loc_18 = _loc_17 as NormalGraphicalElementData;
                                    _loc_3[_loc_18.gfxId] = _loc_18;
                                    if (this._gfxCount[_loc_18.gfxId])
                                    {
                                        var _loc_19:* = this._gfxCount;
                                        var _loc_20:* = _loc_18.gfxId;
                                        var _loc_21:* = this._gfxCount[_loc_18.gfxId] + 1;
                                        _loc_19[_loc_20] = _loc_21;
                                    }
                                    else
                                    {
                                        this._gfxCount[_loc_18.gfxId] = 1;
                                    }
                                }
                            }
                            _loc_14++;
                        }
                        _loc_10++;
                    }
                }
                _loc_5++;
            }
            this._gfxList = new Array();
            for (_loc_6 in _loc_3)
            {
                
                this._gfxList.push(_loc_3[_loc_6]);
            }
            return;
        }// end function

    }
}
