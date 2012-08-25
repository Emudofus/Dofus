package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.frames.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.replay.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Input extends Label implements UIComponent
    {
        private var _nMaxChars:uint;
        private var _bPassword:Boolean = false;
        private var _sRestrictChars:String;
        private var _lastTextOnInput:String;
        public var imeActive:Boolean;
        public var focusEventHandlerPriority:Boolean = true;
        private static const _strReplace:String = "NoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLog";

        public function Input()
        {
            _bHtmlAllowed = false;
            _tText.selectable = true;
            _tText.type = TextFieldType.INPUT;
            _tText.restrict = this._sRestrictChars;
            _tText.maxChars = this._nMaxChars;
            _tText.mouseEnabled = true;
            _autoResize = false;
            _tText.addEventListener(Event.CHANGE, this.onTextChange);
            return;
        }// end function

        public function get lastTextOnInput() : String
        {
            return this._lastTextOnInput;
        }// end function

        public function get maxChars() : uint
        {
            return this._nMaxChars;
        }// end function

        public function set maxChars(param1:uint) : void
        {
            this._nMaxChars = param1;
            _tText.maxChars = this._nMaxChars;
            return;
        }// end function

        public function get password() : Boolean
        {
            return this._bPassword;
        }// end function

        public function set password(param1:Boolean) : void
        {
            this._bPassword = param1;
            if (this._bPassword)
            {
                _tText.displayAsPassword = true;
            }
            return;
        }// end function

        public function get restrictChars() : String
        {
            return this._sRestrictChars;
        }// end function

        public function set restrictChars(param1:String) : void
        {
            this._sRestrictChars = param1;
            _tText.restrict = this._sRestrictChars;
            return;
        }// end function

        public function get haveFocus() : Boolean
        {
            return Berilia.getInstance().docMain.stage.focus == _tText;
        }// end function

        override public function set text(param1:String) : void
        {
            super.text = param1;
            this.onTextChange(null);
            return;
        }// end function

        override public function focus() : void
        {
            Berilia.getInstance().docMain.stage.focus = _tText;
            FocusHandler.getInstance().setFocus(_tText);
            return;
        }// end function

        public function blur() : void
        {
            Berilia.getInstance().docMain.stage.focus = null;
            FocusHandler.getInstance().setFocus(null);
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (param1 is MouseClickMessage && MouseClickMessage(param1).target == this)
            {
                this.focus();
            }
            var _loc_2:* = parseInt(text.split(" ").join("").split("").join(""));
            if (param1 is MouseWheelMessage && !disabled && _loc_2.toString(10) == text.split(" ").join("").split("").join(""))
            {
                _loc_3 = (param1 as MouseWheelMessage).mouseEvent.delta > 0 ? (1) : (-1);
                _loc_4 = Math.abs(_loc_2) > 99 ? (Math.pow(10, (_loc_2 + _loc_3).toString(10).length - 2)) : (1);
                if (ShortcutsFrame.ctrlKey)
                {
                    _loc_4 = 1;
                }
                _loc_5 = _loc_2 + _loc_3 * _loc_4;
                _loc_5 = _loc_5 < 0 ? (0) : (_loc_5);
                this.text = StringUtils.formateIntToString(_loc_5);
            }
            return super.process(param1);
        }// end function

        public function setSelection(param1:int, param2:int) : void
        {
            _tText.setSelection(param1, param2);
            return;
        }// end function

        private function onTextChange(event:Event) : void
        {
            if (this._lastTextOnInput != _tText.text)
            {
                LogFrame.log(LogTypeEnum.KEYBOARD_INPUT, new KeyboardInput(customUnicName, _strReplace.substr(0, _tText.text.length)));
            }
            this._lastTextOnInput = _tText.text;
            Berilia.getInstance().handler.process(new ChangeMessage(InteractiveObject(this)));
            return;
        }// end function

    }
}
