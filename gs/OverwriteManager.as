package gs
{

    public class OverwriteManager extends Object
    {
        public static const version:Number = 1;
        public static const NONE:int = 0;
        public static const ALL:int = 1;
        public static const AUTO:int = 2;
        public static const CONCURRENT:int = 3;
        public static var mode:int;
        public static var enabled:Boolean;

        public function OverwriteManager()
        {
            return;
        }// end function

        public static function init(param1:int = 2) : int
        {
            if (TweenLite.version < 9.29)
            {
                trace("TweenLite warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
            }
            TweenLite.overwriteManager = OverwriteManager;
            mode = param1;
            enabled = true;
            return mode;
        }// end function

        public static function manageOverwrites(param1:TweenLite, param2:Array) : void
        {
            var _loc_7:int = 0;
            var _loc_8:TweenLite = null;
            var _loc_9:Object = null;
            var _loc_10:String = null;
            var _loc_3:* = param1.vars;
            var _loc_4:* = _loc_3.overwrite == undefined ? (mode) : (int(_loc_3.overwrite));
            if ((_loc_3.overwrite == undefined ? (mode) : (int(_loc_3.overwrite))) < 2 || param2 == null)
            {
                return;
            }
            var _loc_5:* = param1.startTime;
            var _loc_6:Array = [];
            _loc_7 = param2.length - 1;
            while (_loc_7 > -1)
            {
                
                _loc_8 = param2[_loc_7];
                if (_loc_8 != param1 && _loc_8.startTime <= _loc_5 && _loc_8.startTime + _loc_8.duration * 1000 / _loc_8.combinedTimeScale > _loc_5)
                {
                    _loc_6[_loc_6.length] = _loc_8;
                }
                _loc_7 = _loc_7 - 1;
            }
            if (_loc_6.length == 0)
            {
                return;
            }
            if (_loc_4 == AUTO)
            {
                if (_loc_3.isTV == true)
                {
                    _loc_3 = _loc_3.exposedProps;
                }
                _loc_9 = {};
                for (_loc_10 in _loc_3)
                {
                    
                    if (_loc_10 == "ease" || _loc_10 == "delay" || _loc_10 == "overwrite" || _loc_10 == "onComplete" || _loc_10 == "onCompleteParams" || _loc_10 == "runBackwards" || _loc_10 == "persist" || _loc_10 == "onUpdate" || _loc_10 == "onUpdateParams" || _loc_10 == "timeScale" || _loc_10 == "onStart" || _loc_10 == "onStartParams" || _loc_10 == "renderOnStart" || _loc_10 == "proxiedEase" || _loc_10 == "easeParams" || _loc_10 == "onCompleteAll" || _loc_10 == "onCompleteAllParams" || _loc_10 == "yoyo" || _loc_10 == "loop" || _loc_10 == "onCompleteListener" || _loc_10 == "onStartListener" || _loc_10 == "onUpdateListener")
                    {
                        continue;
                    }
                    _loc_9[_loc_10] = 1;
                    if (_loc_10 == "shortRotate")
                    {
                        _loc_9.rotation = 1;
                        continue;
                    }
                    if (_loc_10 == "removeTint")
                    {
                        _loc_9.tint = 1;
                        continue;
                    }
                    if (_loc_10 == "autoAlpha")
                    {
                        _loc_9.alpha = 1;
                        _loc_9.visible = 1;
                    }
                }
                _loc_7 = _loc_6.length - 1;
                while (_loc_7 > -1)
                {
                    
                    _loc_6[_loc_7].killVars(_loc_9);
                    _loc_7 = _loc_7 - 1;
                }
            }
            else
            {
                _loc_7 = _loc_6.length - 1;
                while (_loc_7 > -1)
                {
                    
                    _loc_6[_loc_7].enabled = false;
                    _loc_7 = _loc_7 - 1;
                }
            }
            return;
        }// end function

        public static function killVars(param1:Object, param2:Object, param3:Array, param4:Array, param5:Array) : void
        {
            var _loc_6:int = 0;
            var _loc_7:String = null;
            _loc_6 = param4.length - 1;
            while (_loc_6 > -1)
            {
                
                if (param1[param4[_loc_6].name] != undefined)
                {
                    param4.splice(_loc_6, 1);
                }
                _loc_6 = _loc_6 - 1;
            }
            _loc_6 = param3.length - 1;
            while (_loc_6 > -1)
            {
                
                if (param1[param3[_loc_6][4]] != undefined)
                {
                    param3.splice(_loc_6, 1);
                }
                _loc_6 = _loc_6 - 1;
            }
            _loc_6 = param5.length - 1;
            while (_loc_6 > -1)
            {
                
                if (param1[param5[_loc_6].name] != undefined)
                {
                    param5.splice(_loc_6, 1);
                }
                _loc_6 = _loc_6 - 1;
            }
            for (_loc_7 in param1)
            {
                
                delete param2[_loc_7];
            }
            return;
        }// end function

    }
}
