package com.ankamagames.berilia.types.shortcut
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Bind extends Object implements IDataCenter
    {
        public var key:String;
        public var targetedShortcut:String;
        public var alt:Boolean;
        public var ctrl:Boolean;
        public var shift:Boolean;
        public var disabled:Boolean;

        public function Bind(param1:String = null, param2:String = "", param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
        {
            if (param1)
            {
                this.targetedShortcut = param2;
                this.key = param1;
                this.alt = param3;
                this.ctrl = param4;
                this.shift = param5;
                this.disabled = false;
            }
            return;
        }// end function

        public function toString() : String
        {
            var _loc_2:* = null;
            var _loc_1:* = "";
            if (this.key != null)
            {
                _loc_1 = this.alt ? ("Alt+") : ("");
                _loc_1 = _loc_1 + (this.ctrl ? ("Ctrl+") : (""));
                _loc_1 = _loc_1 + (this.shift ? (I18n.getUiText("ui.keyboard.shift") + "+") : (""));
                if (this.key.charAt(0) == "(" && this.key.charAt((this.key.length - 1)) == ")")
                {
                    _loc_2 = this.key.substr(1, this.key.length - 2);
                }
                else
                {
                    _loc_2 = this.key;
                }
                if (I18n.hasUiText("ui.keyboard." + _loc_2.toLowerCase()))
                {
                    _loc_1 = _loc_1 + I18n.getUiText("ui.keyboard." + _loc_2.toLowerCase());
                }
                else
                {
                    _loc_1 = _loc_1 + (this.shift ? (_loc_2.toLowerCase()) : (_loc_2));
                }
            }
            return _loc_1;
        }// end function

        public function equals(param1:Bind) : Boolean
        {
            return param1 && (param1.key == null && this.key == null || this.key != null && param1.key != null && param1.key.toLocaleUpperCase() == this.key.toLocaleUpperCase()) && param1.alt == this.alt && param1.ctrl == this.ctrl && param1.shift == this.shift;
        }// end function

        public function reset() : void
        {
            this.key = null;
            this.alt = false;
            this.ctrl = false;
            this.shift = false;
            return;
        }// end function

        public function copy() : Bind
        {
            var _loc_1:* = new Bind(this.key, this.targetedShortcut, this.alt, this.ctrl, this.shift);
            _loc_1.disabled = this.disabled;
            return _loc_1;
        }// end function

    }
}
