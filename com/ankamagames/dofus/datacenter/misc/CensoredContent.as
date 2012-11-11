package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class CensoredContent extends Object implements ICensoredDataItem, IDataCenter
    {
        private var _type:int;
        private var _oldValue:int;
        private var _newValue:int;
        private var _lang:String;
        public static const MODULE:String = "CensoredContents";

        public function CensoredContent()
        {
            return;
        }// end function

        public function get lang() : String
        {
            return this._lang;
        }// end function

        public function set lang(param1:String) : void
        {
            this._lang = param1;
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set oldValue(param1:int) : void
        {
            this._oldValue = param1;
            return;
        }// end function

        public function get oldValue() : int
        {
            return this._oldValue;
        }// end function

        public function set newValue(param1:int) : void
        {
            this._newValue = param1;
            return;
        }// end function

        public function get newValue() : int
        {
            return this._newValue;
        }// end function

        public static function getCensoredContents() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
