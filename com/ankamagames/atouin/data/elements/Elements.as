package com.ankamagames.atouin.data.elements
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class Elements extends Object
    {
        public var fileVersion:uint;
        public var elementsCount:uint;
        private var _parsed:Boolean;
        private var _failed:Boolean;
        private var _elementsMap:Dictionary;
        private var _jpgMap:Dictionary;
        private var _elementsIndex:Dictionary;
        private var _rawData:IDataInput;
        private static var _self:Elements;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Elements));

        public function Elements() : void
        {
            if (_self)
            {
                throw new SingletonError();
            }
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

        public function getElementData(param1:int) : GraphicalElementData
        {
            return this._elementsMap[param1] ? (GraphicalElementData(this._elementsMap[param1])) : (this.readElement(param1));
        }// end function

        public function isJpg(param1:uint) : Boolean
        {
            return this._jpgMap[param1] == true;
        }// end function

        public function fromRaw(param1:IDataInput) : void
        {
            var header:int;
            var skypLen:uint;
            var i:int;
            var edId:int;
            var gfxCount:int;
            var gfxId:int;
            var raw:* = param1;
            try
            {
                header = raw.readByte();
                if (header != 69)
                {
                    throw new DataFormatError("Unknown file format");
                }
                this._rawData = raw;
                this.fileVersion = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("File version : " + this.fileVersion);
                }
                this.elementsCount = raw.readUnsignedInt();
                if (AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
                {
                    _log.debug("Elements count : " + this.elementsCount);
                }
                this._elementsMap = new Dictionary();
                this._elementsIndex = new Dictionary();
                skypLen;
                i;
                while (i < this.elementsCount)
                {
                    
                    if (this.fileVersion >= 9)
                    {
                        skypLen = raw.readUnsignedShort();
                    }
                    edId = raw.readInt();
                    if (this.fileVersion <= 8)
                    {
                        this._elementsIndex[edId] = raw["position"];
                        this.readElement(edId);
                    }
                    else
                    {
                        this._elementsIndex[edId] = raw["position"];
                        raw["position"] = raw["position"] + (skypLen - 4);
                    }
                    i = (i + 1);
                }
                if (this.fileVersion >= 8)
                {
                    gfxCount = raw.readInt();
                    this._jpgMap = new Dictionary();
                    i;
                    while (i < gfxCount)
                    {
                        
                        gfxId = raw.readInt();
                        this._jpgMap[gfxId] = true;
                        i = (i + 1);
                    }
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

        private function readElement(param1:uint) : GraphicalElementData
        {
            this._rawData["position"] = this._elementsIndex[param1];
            var _loc_2:* = this._rawData.readByte();
            var _loc_3:* = GraphicalElementFactory.getGraphicalElementData(param1, _loc_2);
            _loc_3.fromRaw(this._rawData, this.fileVersion);
            this._elementsMap[param1] = _loc_3;
            return _loc_3;
        }// end function

        public static function getInstance() : Elements
        {
            if (!_self)
            {
                _self = new Elements;
            }
            return _self;
        }// end function

    }
}
