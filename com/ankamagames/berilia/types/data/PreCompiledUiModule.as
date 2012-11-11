package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.types.uiDefinition.*;
    import flash.net.*;
    import flash.utils.*;

    public class PreCompiledUiModule extends UiModule
    {
        private var _uiListPosition:Dictionary;
        private var _definitionCount:uint;
        private var _uiListStartPosition:uint;
        private var _output:ByteArray;
        private var _uiBuffer:ByteArray;
        private var _input:ByteArray;
        private var _cacheDefinition:Dictionary;
        private static const HEADER_STR:String = "D2UI";

        public function PreCompiledUiModule()
        {
            return;
        }// end function

        public function hasDefinition(param1:UiData) : Boolean
        {
            return this._uiListPosition[param1.name] != null;
        }// end function

        public function getDefinition(param1:UiData) : UiDefinition
        {
            if (this.hasDefinition(param1))
            {
                if (this._cacheDefinition[param1.name])
                {
                    return this._cacheDefinition[param1.name];
                }
                return this.readUidefinition(param1.name);
            }
            return null;
        }// end function

        public function addUiDefinition(param1:UiDefinition, param2:UiData) : void
        {
            if (!this._output)
            {
                throw new Error("Call method \'create\' before using this method");
            }
            this.writeUiDefinition(param1, param2);
            return;
        }// end function

        public function flush(param1:IDataOutput) : void
        {
            var _loc_2:* = null;
            if (!this._output)
            {
                throw new Error("Call method \'create\' before using this method");
            }
            this._output.position = this._uiListStartPosition;
            this._output.writeShort(this._definitionCount);
            param1.writeBytes(this._output);
            this._output.position = this._output.length;
            var _loc_3:* = new ByteArray();
            for (_loc_2 in this._uiListPosition)
            {
                
                _loc_3.writeUTF(_loc_2);
                _loc_3.writeInt(0);
            }
            _loc_3.position = 0;
            for (_loc_2 in this._uiListPosition)
            {
                
                _loc_3.readUTF();
                _loc_3.writeInt(this._uiListPosition[_loc_2] + this._output.length + _loc_3.length);
            }
            param1.writeBytes(_loc_3);
            param1.writeBytes(this._uiBuffer);
            return;
        }// end function

        private function initWriteMode() : void
        {
            this._output = new ByteArray();
            this._uiBuffer = new ByteArray();
            this._uiListPosition = new Dictionary();
            this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
            return;
        }// end function

        private function makeHeader(param1:UiModule) : void
        {
            this._output.writeUTF("D2UI");
            this._output.writeUTF(param1.rawXml.toXMLString());
            this._uiListStartPosition = this._output.position;
            this._output.writeShort(0);
            return;
        }// end function

        private function readUidefinition(param1:String) : UiDefinition
        {
            this._input.objectEncoding = ObjectEncoding.AMF3;
            this._input.position = this._uiListPosition[param1];
            return this._input.readObject();
        }// end function

        private function writeUiDefinition(param1:UiDefinition, param2:UiData) : void
        {
            var _loc_3:* = this;
            var _loc_4:* = this._definitionCount + 1;
            _loc_3._definitionCount = _loc_4;
            this._uiListPosition[param2.name] = this._uiBuffer.position;
            this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
            this._uiBuffer.writeObject(param1);
            return;
        }// end function

        public static function fromRaw(param1:IDataInput, param2:String, param3:String) : PreCompiledUiModule
        {
            var _loc_4:* = new PreCompiledUiModule;
            var _loc_5:* = new ByteArray();
            _loc_4._input = _loc_5;
            param1.readBytes(_loc_5);
            _loc_5.position = 0;
            var _loc_6:* = _loc_5.readUTF();
            if (_loc_5.readUTF() != HEADER_STR)
            {
                throw new Error("Malformated ui data file.");
            }
            _loc_4.fillFromXml(new XML(_loc_5.readUTF()), param2, param3);
            _loc_4._definitionCount = _loc_5.readShort();
            _loc_4._uiListPosition = new Dictionary();
            _loc_4._cacheDefinition = new Dictionary();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4._definitionCount)
            {
                
                _loc_4._uiListPosition[_loc_5.readUTF()] = _loc_5.readInt();
                _loc_7 = _loc_7 + 1;
            }
            return _loc_4;
        }// end function

        public static function create(param1:UiModule) : PreCompiledUiModule
        {
            var _loc_2:* = new PreCompiledUiModule;
            _loc_2.initWriteMode();
            _loc_2.makeHeader(param1);
            return _loc_2;
        }// end function

    }
}
