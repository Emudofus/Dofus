package com.ankamagames.dofus.logic.game.common.frames
{
    import com.adobe.crypto.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ProtectPishingFrame extends Object implements Frame
    {
        private var _inputBufferRef:Dictionary;
        private var _advancedInputBufferRef:Dictionary;
        private var _cancelTarget:Dictionary;
        private var _globalModBuffer:String;
        private var _globalBuffer:String;
        private static var _passwordHash:String;
        private static var _passwordLength:uint;

        public function ProtectPishingFrame()
        {
            this._inputBufferRef = new Dictionary(true);
            this._advancedInputBufferRef = new Dictionary(true);
            this._cancelTarget = new Dictionary(true);
            return;
        }// end function

        public function pushed() : Boolean
        {
            if (_passwordHash && _passwordLength)
            {
                StageShareManager.stage.addEventListener(Event.CHANGE, this.onChange);
                StageShareManager.stage.addEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            }
            return _passwordLength != 0;
        }// end function

        public function pulled() : Boolean
        {
            if (_passwordHash && _passwordLength)
            {
                StageShareManager.stage.removeEventListener(Event.CHANGE, this.onChange);
                StageShareManager.stage.removeEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            }
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:Input = null;
            var _loc_3:Object = null;
            switch(true)
            {
                case param1 is ChangeMessage:
                {
                    _loc_2 = ChangeMessage(param1).target as Input;
                    if (_loc_2 && this._cancelTarget[_loc_2.textfield])
                    {
                        this._cancelTarget[Input(ChangeMessage(param1).target).textfield] = false;
                        _loc_3 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        if (_loc_2.getUi().uiModule.trusted)
                        {
                            _loc_3.openPopup(I18n.getUiText("ui.popup.warning"), I18n.getUiText("ui.popup.warning.password"), [I18n.getUiText("ui.common.ok")]);
                        }
                        else
                        {
                            _loc_3.openPopup(I18n.getUiText("ui.popup.warning.pishing.title"), I18n.getUiText("ui.popup.warning.pishing.content"), [I18n.getUiText("ui.common.ok")]);
                            _loc_2.getUi().uiModule.enable = false;
                        }
                        return true;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function get priority() : int
        {
            return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
        }// end function

        private function onTextInput(event:TextEvent) : void
        {
            var _loc_4:uint = 0;
            this._globalBuffer = this._globalBuffer + event.text;
            if (!(event.target is TextField && TextField(event.target).parent is Input && Input(TextField(event.target).parent).getUi() && !Input(TextField(event.target).parent).getUi().uiModule.trusted))
            {
                return;
            }
            this._globalModBuffer = this._globalModBuffer + event.text;
            if (!this._advancedInputBufferRef[event.target])
            {
                this._advancedInputBufferRef[event.target] = "";
            }
            var _loc_2:* = this._advancedInputBufferRef[event.target];
            var _loc_3:* = _loc_2;
            _loc_2 = _loc_2 + event.text;
            if (_loc_2.length >= _passwordLength)
            {
                _loc_4 = _loc_2.length - _passwordLength + 1;
                if (this.detectHash(_loc_2, _passwordHash, _passwordLength))
                {
                    event.preventDefault();
                    this._cancelTarget[event.target] = true;
                    this._advancedInputBufferRef[event.target] = _loc_3;
                    return;
                }
                _loc_2 = _loc_2.substr(_loc_4);
            }
            if (this._globalBuffer.length >= _passwordLength)
            {
                _loc_4 = this._globalBuffer.length - _passwordLength + 1;
                if (this.detectHash(this._globalBuffer, _passwordHash, _passwordLength))
                {
                    event.preventDefault();
                    this._cancelTarget[event.target] = true;
                    return;
                }
                this._globalBuffer = this._globalBuffer.substr(_loc_4);
            }
            if (this._globalModBuffer.length >= _passwordLength)
            {
                _loc_4 = this._globalModBuffer.length - _passwordLength + 1;
                if (this.detectHash(this._globalModBuffer, _passwordHash, _passwordLength))
                {
                    event.preventDefault();
                    this._cancelTarget[event.target] = true;
                    return;
                }
                this._globalModBuffer = this._globalModBuffer.substr(_loc_4);
            }
            this._advancedInputBufferRef[event.target] = _loc_2;
            return;
        }// end function

        private function detectHash(param1:String, param2:String, param3:uint) : Boolean
        {
            var _loc_4:* = param1.length - param3 + 1;
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (MD5.hash(param1.substr(_loc_5, param3).toUpperCase()) == param2)
                {
                    return true;
                }
                _loc_5 = _loc_5 + 1;
            }
            return false;
        }// end function

        protected function onChange(event:Event) : void
        {
            var _loc_5:uint = 0;
            var _loc_6:String = null;
            var _loc_7:uint = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = event.target as TextField;
            if (!_loc_3)
            {
                return;
            }
            if (!this._inputBufferRef[event.target])
            {
                this._inputBufferRef[event.target] = "";
            }
            var _loc_4:* = this._inputBufferRef[event.target];
            if (this._inputBufferRef[event.target].length >= _passwordLength)
            {
                if (_loc_3.text.substring(0, _loc_4.length) == _loc_4)
                {
                    _loc_4 = _loc_3.text.substring(_loc_4.length - _passwordLength);
                }
                else if (_loc_4.substring(0, _loc_3.text.length) == _loc_3.text)
                {
                    _loc_4 = _loc_4.substring(_loc_3.text.length - _passwordLength);
                }
                else
                {
                    _loc_4 = _loc_3.text;
                }
            }
            else
            {
                _loc_4 = _loc_3.text;
            }
            if (_loc_4.length >= _passwordLength)
            {
                _loc_5 = _loc_4.length - _passwordLength + 1;
                _loc_6 = _loc_4.toUpperCase();
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    if (MD5.hash(_loc_6.substr(_loc_7, _passwordLength)) == _passwordHash)
                    {
                        _loc_3.text = _loc_3.text.split(_loc_4.substr(_loc_7, _passwordLength)).join("");
                        this._cancelTarget[_loc_3] = true;
                        break;
                    }
                    _loc_7 = _loc_7 + 1;
                }
            }
            _loc_4 = _loc_3.text;
            this._inputBufferRef[event.target] = _loc_4;
            return;
        }// end function

        public static function setPasswordHash(param1:String, param2:uint) : void
        {
            _passwordHash = param1;
            _passwordLength = param2;
            return;
        }// end function

    }
}
