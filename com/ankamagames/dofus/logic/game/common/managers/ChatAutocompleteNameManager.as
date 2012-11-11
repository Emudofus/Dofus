package com.ankamagames.dofus.logic.game.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.uiApi.*;
    import flash.utils.*;

    public class ChatAutocompleteNameManager extends Object
    {
        public var playerApi:PlayedCharacterApi;
        private var _dict:Dictionary;
        private var _cache:Vector.<String>;
        private var _subStringCache:String = "";
        private static var _instance:ChatAutocompleteNameManager;

        public function ChatAutocompleteNameManager()
        {
            this._dict = new Dictionary();
            return;
        }// end function

        public function addEntry(param1:String, param2:int) : void
        {
            var _loc_3:* = null;
            this.emptyCache();
            var _loc_4:* = this.getListByName(param1);
            var _loc_5:* = this.indexOf(_loc_4, param1);
            if (this.indexOf(_loc_4, param1) != -1)
            {
                _loc_3 = _loc_4[_loc_5];
                if (_loc_3.priority > param2)
                {
                    return;
                }
                _loc_4.splice(_loc_5, 1);
            }
            _loc_3 = new Object();
            _loc_3.name = param1;
            _loc_3.priority = param2;
            this.insertEntry(_loc_3);
            return;
        }// end function

        public function autocomplete(param1:String, param2:uint) : String
        {
            var _loc_3:* = null;
            if (this._subStringCache == param1)
            {
                _loc_3 = this._cache;
            }
            else
            {
                _loc_3 = this.generateNameList(param1);
            }
            if (_loc_3.length > param2)
            {
                return _loc_3[param2];
            }
            return null;
        }// end function

        private function emptyCache() : void
        {
            this._subStringCache = "";
            return;
        }// end function

        private function generateNameList(param1:String) : Vector.<String>
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.toLowerCase();
            var _loc_3:* = this.getListByName(param1);
            var _loc_4:* = new Vector.<String>;
            this._subStringCache = param1;
            this._cache = _loc_4;
            for each (_loc_5 in _loc_3)
            {
                
                _loc_6 = _loc_5.name;
                _loc_7 = _loc_6.toLowerCase();
                if (_loc_5.name.length >= _loc_2.length && _loc_7.substr(0, _loc_2.length) == _loc_2 && _loc_6 != PlayedCharacterApi.getPlayedCharacterInfo().name)
                {
                    _loc_4.push(_loc_6);
                }
            }
            return _loc_4;
        }// end function

        private function getListByName(param1:String) : Vector.<Object>
        {
            var _loc_2:* = param1.charAt(0).toLowerCase();
            if (!this._dict.hasOwnProperty(_loc_2))
            {
                this._dict[_loc_2] = new Vector.<Object>;
            }
            return this._dict[_loc_2];
        }// end function

        private function indexOf(param1:Vector.<Object>, param2:String) : int
        {
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3].name == param2)
                {
                    return _loc_3;
                }
                _loc_3 = _loc_3 + 1;
            }
            return -1;
        }// end function

        private function insertEntry(param1:Object) : void
        {
            var _loc_2:* = this.getListByName(param1.name);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length && _loc_2[_loc_3].priority > param1.priority)
            {
                
                _loc_3 = _loc_3 + 1;
            }
            _loc_2.splice(_loc_3, 0, param1);
            return;
        }// end function

        public static function getInstance() : ChatAutocompleteNameManager
        {
            if (!_instance)
            {
                _instance = new ChatAutocompleteNameManager;
            }
            return _instance;
        }// end function

    }
}
