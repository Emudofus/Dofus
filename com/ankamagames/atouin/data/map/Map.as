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
        public var isUsingNewMovementSystem:Boolean = false;
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
            var i:int;
            var header:int;
            var bg:Fixture;
            var la:Layer;
            var _oldMvtSystem:uint;
            var cd:CellData;
            var dataLen:uint;
            var encryptedData:ByteArray;
            var fg:Fixture;
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
                        i;
                        while (i < encryptedData.length)
                        {
                            
                            encryptedData[i] = encryptedData[i] ^ decryptionKey[i % decryptionKey.length];
                            i = (i + 1);
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
                i;
                while (i < this.foregroundsCount)
                {
                    
                    fg = new Fixture(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Foreground at index " + i + " :");
                    }
                    fg.fromRaw(raw);
                    this.foregroundFixtures.push(fg);
                    i = (i + 1);
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
                i;
                while (i < this.layersCount)
                {
                    
                    la = new Layer(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Layer at index " + i + " :");
                    }
                    la.fromRaw(raw, this.mapVersion);
                    this.layers.push(la);
                    i = (i + 1);
                }
                this.cells = new Array();
                i;
                while (i < this.cellsCount)
                {
                    
                    cd = new CellData(this);
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("Cell data at index " + i + " :");
                    }
                    cd.fromRaw(raw);
                    if (!_oldMvtSystem)
                    {
                        _oldMvtSystem = cd.moveZone;
                    }
                    if (cd.moveZone != _oldMvtSystem)
                    {
                        this.isUsingNewMovementSystem = true;
                    }
                    this.cells.push(cd);
                    i = (i + 1);
                }
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    trace(this.isUsingNewMovementSystem ? ("This map is using the new movement system") : ("This map is using the old movement system"));
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
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_2:* = Elements.getInstance();
            var _loc_3:* = new Array();
            this._gfxCount = new Array();
            var _loc_4:* = this.layers.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_12 = this.layers[_loc_5];
                if (param1 && _loc_5 == 0)
                {
                }
                else
                {
                    _loc_8 = _loc_12.cells;
                    _loc_9 = _loc_8.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_9)
                    {
                        
                        _loc_13 = _loc_8[_loc_6];
                        _loc_10 = _loc_13.elements;
                        _loc_11 = _loc_10.length;
                        _loc_7 = 0;
                        while (_loc_7 < _loc_11)
                        {
                            
                            _loc_14 = _loc_10[_loc_7];
                            if (_loc_14.elementType == ElementTypesEnum.GRAPHICAL)
                            {
                                _loc_15 = GraphicalElement(_loc_14).elementId;
                                _loc_16 = _loc_2.getElementData(_loc_15);
                                if (_loc_16 == null)
                                {
                                    _log.error("Unknown graphical element ID " + _loc_15);
                                    ;
                                }
                                else if (_loc_16 is NormalGraphicalElementData)
                                {
                                    _loc_17 = _loc_16 as NormalGraphicalElementData;
                                    _loc_3[_loc_17.gfxId] = _loc_17;
                                    if (this._gfxCount[_loc_17.gfxId])
                                    {
                                        var _loc_19:* = this._gfxCount;
                                        var _loc_20:* = _loc_17.gfxId;
                                        var _loc_21:* = this._gfxCount[_loc_17.gfxId] + 1;
                                        _loc_19[_loc_20] = _loc_21;
                                    }
                                    else
                                    {
                                        this._gfxCount[_loc_17.gfxId] = 1;
                                    }
                                }
                            }
                            _loc_7++;
                        }
                        _loc_6++;
                    }
                }
                _loc_5++;
            }
            this._gfxList = new Array();
            for (_loc_18 in _loc_3)
            {
                
                this._gfxList.push(_loc_3[_loc_18]);
            }
            return;
        }// end function

    }
}
