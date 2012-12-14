package mx.utils
{
    import flash.display.*;
    import flash.utils.*;
    import mx.core.*;

    public class NameUtil extends Object
    {
        static const VERSION:String = "4.6.0.23201";
        private static var counter:int = 0;

        public function NameUtil()
        {
            return;
        }// end function

        public static function createUniqueName(param1:Object) : String
        {
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = _loc_2.indexOf("::");
            if (_loc_3 != -1)
            {
                _loc_2 = _loc_2.substr(_loc_3 + 2);
            }
            var _loc_4:* = _loc_2.charCodeAt((_loc_2.length - 1));
            if (_loc_2.charCodeAt((_loc_2.length - 1)) >= 48 && _loc_4 <= 57)
            {
                _loc_2 = _loc_2 + "_";
            }
            return _loc_2 + counter++;
        }// end function

        public static function displayObjectToString(param1:DisplayObject) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            try
            {
                _loc_3 = param1;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.parent && _loc_3.stage && _loc_3.parent == _loc_3.stage)
                    {
                        break;
                    }
                    _loc_4 = "id" in _loc_3 && _loc_3["id"] ? (_loc_3["id"]) : (_loc_3.name);
                    if (_loc_3 is IRepeaterClient)
                    {
                        _loc_5 = IRepeaterClient(_loc_3).instanceIndices;
                        if (_loc_5)
                        {
                            _loc_4 = _loc_4 + ("[" + _loc_5.join("][") + "]");
                        }
                    }
                    _loc_2 = _loc_2 == null ? (_loc_4) : (_loc_4 + "." + _loc_2);
                    _loc_3 = _loc_3.parent;
                }
            }
            catch (e:SecurityError)
            {
            }
            return _loc_2;
        }// end function

        public static function getUnqualifiedClassName(param1:Object) : String
        {
            var _loc_2:* = null;
            if (param1 is String)
            {
                _loc_2 = param1 as String;
            }
            else
            {
                _loc_2 = getQualifiedClassName(param1);
            }
            var _loc_3:* = _loc_2.indexOf("::");
            if (_loc_3 != -1)
            {
                _loc_2 = _loc_2.substr(_loc_3 + 2);
            }
            return _loc_2;
        }// end function

    }
}
