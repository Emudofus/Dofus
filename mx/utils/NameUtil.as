package mx.utils
{
    import flash.display.*;
    import flash.utils.*;
    import mx.core.*;

    public class NameUtil extends Object
    {
        static const VERSION:String = "4.1.0.16076";
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
            var result:String;
            var o:DisplayObject;
            var s:String;
            var indices:Array;
            var displayObject:* = param1;
            try
            {
                o = displayObject;
                while (o != null)
                {
                    
                    if (o.parent && o.stage && o.parent == o.stage)
                    {
                        break;
                    }
                    s = "id" in o && o["id"] ? (o["id"]) : (o.name);
                    if (o is IRepeaterClient)
                    {
                        indices = IRepeaterClient(o).instanceIndices;
                        if (indices)
                        {
                            s = s + ("[" + indices.join("][") + "]");
                        }
                    }
                    result = result == null ? (s) : (s + "." + result);
                    o = o.parent;
                }
            }
            catch (e:SecurityError)
            {
            }
            return result;
        }// end function

        public static function getUnqualifiedClassName(param1:Object) : String
        {
            var _loc_2:String = null;
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
