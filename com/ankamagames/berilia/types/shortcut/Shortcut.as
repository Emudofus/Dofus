package com.ankamagames.berilia.types.shortcut
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Shortcut extends Object implements IDataCenter
    {
        private var _name:String;
        private var _description:String;
        private var _textfieldEnabled:Boolean;
        private var _bindable:Boolean;
        private var _category:ShortcutCategory;
        private var _unicID:uint;
        private var _visible:Boolean;
        private var _disable:Boolean;
        public var defaultBind:Bind;
        private static var _shortcuts:Array = new Array();
        private static var _idCount:uint = 0;

        public function Shortcut(param1:String, param2:Boolean = false, param3:String = null, param4:ShortcutCategory = null, param5:Boolean = true, param6:Boolean = true)
        {
            if (_shortcuts[param1])
            {
                throw new BeriliaError("Shortcut name [" + param1 + "] is already use");
            }
            _shortcuts[param1] = this;
            this._name = param1;
            this._description = param3;
            this._textfieldEnabled = param2;
            this._category = param4;
            this._unicID = _idCount + 1;
            this._bindable = param5;
            this._visible = param6;
            this._disable = false;
            BindsManager.getInstance().newShortcut(this);
            return;
        }// end function

        public function get unicID() : uint
        {
            return this._unicID;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function get textfieldEnabled() : Boolean
        {
            return this._textfieldEnabled;
        }// end function

        public function get bindable() : Boolean
        {
            return this._bindable;
        }// end function

        public function get category() : ShortcutCategory
        {
            return this._category;
        }// end function

        public function get visible() : Boolean
        {
            return this._visible;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this._visible = param1;
            return;
        }// end function

        public function get disable() : Boolean
        {
            return this._disable;
        }// end function

        public function set disable(param1:Boolean) : void
        {
            this._disable = param1;
            return;
        }// end function

        public static function reset() : void
        {
            BindsManager.destroy();
            _shortcuts = [];
            _idCount = 0;
            return;
        }// end function

        public static function getShortcutByName(param1:String) : Shortcut
        {
            return _shortcuts[param1];
        }// end function

        public static function getShortcuts() : Array
        {
            return _shortcuts;
        }// end function

    }
}
