package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.*;
    import com.ankamagames.tiphon.engine.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Skin extends EventDispatcher
    {
        private var _ressourceCount:uint = 0;
        private var _ressourceLoading:uint = 0;
        private var _skinParts:Array;
        private var _skinClass:Array;
        private var _aSkinPartOrdered:Array;
        private var _validate:Boolean = true;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(Skin));
        private static var _censoredSkin:Dictionary;
        private static var _alternativeSkin:Dictionary = new Dictionary();

        public function Skin()
        {
            this._skinParts = new Array();
            this._skinClass = new Array();
            this._aSkinPartOrdered = new Array();
            return;
        }// end function

        public function get complete() : Boolean
        {
            var _loc_2:* = 0;
            if (!this._validate)
            {
                return false;
            }
            var _loc_1:* = true;
            for each (_loc_2 in this._aSkinPartOrdered)
            {
                
                _loc_1 = _loc_1 && (Tiphon.skinLibrary.isLoaded(_loc_2) || Tiphon.skinLibrary.hasError(_loc_2));
            }
            return _loc_1;
        }// end function

        public function get validate() : Boolean
        {
            return this._validate;
        }// end function

        public function set validate(param1:Boolean) : void
        {
            this._validate = param1;
            if (param1 && this.complete)
            {
                this.processSkin();
            }
            return;
        }// end function

        public function add(param1:uint, param2:int = -1) : uint
        {
            var _loc_3:* = -1;
            if (!_censoredSkin)
            {
                _censoredSkin = CensoredContentManager.getInstance().getCensoredIndex(2);
            }
            if (_censoredSkin[param1])
            {
                param1 = _censoredSkin[param1];
            }
            if (param2 != -1 && _alternativeSkin && _alternativeSkin[param1] && param2 < _alternativeSkin[param1].length)
            {
                _loc_3 = param1;
                param1 = _alternativeSkin[param1][param2];
            }
            var _loc_4:* = new Array();
            var _loc_5:* = 0;
            while (_loc_5 < this._aSkinPartOrdered.length)
            {
                
                if (this._aSkinPartOrdered[_loc_5] != param1 && this._aSkinPartOrdered[_loc_5] != _loc_3)
                {
                    _loc_4.push(this._aSkinPartOrdered[_loc_5]);
                }
                _loc_5 = _loc_5 + 1;
            }
            _loc_4.push(param1);
            if (this._aSkinPartOrdered.length != _loc_4.length)
            {
                this._aSkinPartOrdered = _loc_4;
                var _loc_6:* = this;
                var _loc_7:* = this._ressourceLoading + 1;
                _loc_6._ressourceLoading = _loc_7;
                Tiphon.skinLibrary.addResource(param1, new Uri(TiphonConstants.SWF_SKIN_PATH + param1 + ".swl"));
                Tiphon.skinLibrary.askResource(param1, null, new Callback(this.onResourceLoaded, param1), new Callback(this.onResourceLoaded, param1));
            }
            else
            {
                this._aSkinPartOrdered = _loc_4;
            }
            return param1;
        }// end function

        public function getPart(param1:String) : Sprite
        {
            var _loc_2:* = this._skinParts[param1];
            if (_loc_2 && !_loc_2.parent)
            {
                return _loc_2;
            }
            if (this._skinClass[param1])
            {
                _loc_2 = new this._skinClass[param1];
                this._skinParts[param1] = _loc_2;
                return _loc_2;
            }
            return null;
        }// end function

        public function reset() : void
        {
            this._skinParts = new Array();
            this._skinClass = new Array();
            this._aSkinPartOrdered = new Array();
            return;
        }// end function

        private function onResourceLoaded(param1:uint) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._ressourceCount + 1;
            _loc_2._ressourceCount = _loc_3;
            var _loc_2:* = this;
            var _loc_3:* = this._ressourceLoading - 1;
            _loc_2._ressourceLoading = _loc_3;
            this.processSkin();
            return;
        }// end function

        private function processSkin() : void
        {
            var _loc_1:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aSkinPartOrdered.length)
            {
                
                _loc_1 = this._aSkinPartOrdered[_loc_2];
                _loc_3 = Tiphon.skinLibrary.getResourceById(_loc_1);
                if (!_loc_3)
                {
                }
                else
                {
                    _loc_4 = _loc_3.getDefinitions();
                    for each (_loc_5 in _loc_4)
                    {
                        
                        this._skinClass[_loc_5] = _loc_3.getDefinition(_loc_5);
                        delete this._skinParts[_loc_5];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this.complete)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            else
            {
                dispatchEvent(new Event(ProgressEvent.PROGRESS));
            }
            return;
        }// end function

        public static function addAlternativeSkin(param1:uint, param2:uint) : void
        {
            if (!_alternativeSkin[param1])
            {
                _alternativeSkin[param1] = new Array();
            }
            _alternativeSkin[param1].push(param2);
            return;
        }// end function

    }
}
