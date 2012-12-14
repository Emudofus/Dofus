package com.ankamagames.berilia.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import flash.utils.*;

    public class UiSoundManager extends Object
    {
        private var _registeredHook:Dictionary;
        private var _registeredUi:Dictionary;
        private var _registeredUiElement:Dictionary;
        public var playSound:Function;
        public static const UI_LOAD:uint = 0;
        public static const UI_UNLOAD:uint = 1;
        private static var _self:UiSoundManager;

        public function UiSoundManager()
        {
            this._registeredHook = new Dictionary();
            this._registeredUi = new Dictionary();
            this._registeredUiElement = new Dictionary();
            return;
        }// end function

        public function registerUi(param1:String, param2:String = null, param3:String = null) : void
        {
            var _loc_4:* = this._registeredUi[param1];
            if (!this._registeredUi[param1])
            {
                _loc_4 = new BeriliaUiSound();
                _loc_4.uiName = param1;
                _loc_4.openFile = param2;
                _loc_4.closeFile = param3;
                this._registeredUi[param1] = _loc_4;
            }
            else
            {
                _loc_4.openFile = param2;
                _loc_4.closeFile = param3;
            }
            return;
        }// end function

        public function getUi(param1:String) : BeriliaUiSound
        {
            return this._registeredUi[param1];
        }// end function

        public function registerUiElement(param1:String, param2:String, param3:String, param4:String) : void
        {
            var _loc_5:* = new BeriliaUiElementSound();
            new BeriliaUiElementSound().name = param2;
            _loc_5.file = param4;
            _loc_5.hook = param3;
            this._registeredUiElement[param1 + "::" + param2 + "::" + param3] = _loc_5;
            return;
        }// end function

        public function fromHook(param1:Hook, param2:Array = null) : Boolean
        {
            return true;
        }// end function

        public function getAllSoundUiElement(param1:GraphicContainer) : Vector.<BeriliaUiElementSound>
        {
            var _loc_5:* = null;
            var _loc_2:* = new Vector.<BeriliaUiElementSound>;
            var _loc_3:* = param1.getUi().name + "::";
            var _loc_4:* = _loc_3.length;
            for (_loc_5 in this._registeredUiElement)
            {
                
                if (_loc_5.substr(0, _loc_4) == _loc_3 && _loc_5.substr(_loc_4, param1.name.length) == param1.name)
                {
                    _loc_2.push(this._registeredUiElement[_loc_5]);
                }
            }
            return _loc_2;
        }// end function

        public function fromUiElement(param1:GraphicContainer, param2:String) : Boolean
        {
            if (!param1 || !param2 || !param1.getUi())
            {
                return false;
            }
            var _loc_3:* = this._registeredUiElement[param1.getUi().name + "::" + param1.name + "::" + param2];
            if (param1.getUi() && _loc_3)
            {
                if (this.playSound != null)
                {
                    this.playSound(_loc_3.file);
                }
                return true;
            }
            return false;
        }// end function

        public function fromUi(param1:UiRootContainer, param2:uint) : Boolean
        {
            if (this._registeredUi[param1.name])
            {
                return true;
            }
            return false;
        }// end function

        public static function getInstance() : UiSoundManager
        {
            if (!_self)
            {
                _self = new UiSoundManager;
            }
            return _self;
        }// end function

    }
}
