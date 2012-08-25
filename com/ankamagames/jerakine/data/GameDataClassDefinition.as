package com.ankamagames.jerakine.data
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class GameDataClassDefinition extends Object
    {
        private var _class:Class;
        private var _fields:Vector.<GameDataField>;

        public function GameDataClassDefinition(param1:String, param2:String)
        {
            this._class = getDefinitionByName(param1 + "." + param2) as Class;
            this._fields = new Vector.<GameDataField>;
            return;
        }// end function

        public function read(param1:String, param2:IDataInput)
        {
            var _loc_4:GameDataField = null;
            var _loc_3:* = new this._class();
            for each (_loc_4 in this._fields)
            {
                
                _loc_3[_loc_4.name] = _loc_4.readData(param1, param2);
            }
            if (_loc_3 is IPostInit)
            {
                IPostInit(_loc_3).postInit();
            }
            return _loc_3;
        }// end function

        public function addField(param1:String, param2:IDataInput) : void
        {
            var _loc_3:* = new GameDataField(param1);
            _loc_3.readType(param2);
            this._fields.push(_loc_3);
            return;
        }// end function

    }
}
