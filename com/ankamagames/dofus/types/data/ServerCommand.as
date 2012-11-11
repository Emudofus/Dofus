package com.ankamagames.dofus.types.data
{

    public class ServerCommand extends Object
    {
        public var name:String;
        public var help:String;
        private static var _cmdList:Array = [];
        private static var _cmdByName:Array = [];

        public function ServerCommand(param1:String, param2:String)
        {
            this.name = param1;
            this.help = param2;
            if (!_cmdByName[param1])
            {
                _cmdByName[param1] = this;
                _cmdList.push(param1);
            }
            return;
        }// end function

        public static function get commandList() : Array
        {
            return _cmdList;
        }// end function

        public static function autoComplete(param1:String) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_2:* = new Array();
            for (_loc_3 in _cmdByName)
            {
                
                if (_loc_3.indexOf(param1) == 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            if (_loc_2.length > 1)
            {
                _loc_4 = "";
                _loc_5 = true;
                _loc_6 = 1;
                while (_loc_6 < 30)
                {
                    
                    if (_loc_6 > _loc_2[0].length)
                    {
                        break;
                    }
                    for each (_loc_3 in _loc_2)
                    {
                        
                        _loc_5 = _loc_5 && _loc_3.indexOf(_loc_2[0].substr(0, _loc_6)) == 0;
                        if (!_loc_5)
                        {
                            break;
                        }
                    }
                    if (_loc_5)
                    {
                        _loc_4 = _loc_2[0].substr(0, _loc_6);
                    }
                    else
                    {
                        break;
                    }
                    _loc_6 = _loc_6 + 1;
                }
                return _loc_4;
            }
            else
            {
            }
            return _loc_2[0];
        }// end function

        public static function getAutoCompletePossibilities(param1:String) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = new Array();
            for (_loc_3 in _cmdByName)
            {
                
                if (_loc_3.indexOf(param1) == 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public static function getHelp(param1:String) : String
        {
            return _cmdByName[param1] ? (_cmdByName[param1].help) : (null);
        }// end function

        public static function hasCommand(param1:String) : Boolean
        {
            return _cmdByName.hasOwnProperty(param1);
        }// end function

    }
}
