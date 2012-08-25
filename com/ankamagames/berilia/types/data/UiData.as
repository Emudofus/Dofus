package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.utils.errors.*;

    public class UiData extends Object
    {
        private var _name:String;
        private var _file:String;
        private var _uiClassName:String;
        private var _uiClass:Class;
        private var _xml:String;
        private var _uiGroupName:String;
        private var _module:UiModule;

        public function UiData(param1:UiModule, param2:String, param3:String, param4:String, param5:String = null)
        {
            this._module = param1;
            this._name = param2;
            this._file = param3;
            this._uiClassName = param4;
            this._uiGroupName = param5;
            return;
        }// end function

        public function get module() : UiModule
        {
            return this._module;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get file() : String
        {
            return this._file;
        }// end function

        public function get uiClassName() : String
        {
            return this._uiClassName;
        }// end function

        public function get xml() : String
        {
            return this._xml;
        }// end function

        public function get uiGroupName() : String
        {
            return this._uiGroupName;
        }// end function

        public function set xml(param1:String) : void
        {
            if (this._xml)
            {
                throw new BeriliaError("xml cannot be set twice");
            }
            this._xml = param1;
            return;
        }// end function

        public function get uiClass() : Class
        {
            return this._uiClass;
        }// end function

        public function set uiClass(param1:Class) : void
        {
            if (this._uiClass)
            {
                throw new BeriliaError("uiClass cannot be set twice");
            }
            this._uiClass = param1;
            return;
        }// end function

    }
}
