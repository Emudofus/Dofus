package com.ankamagames.tiphon.engine
{
    import __AS3__.vec.*;

    final public class SubstituteAnimationManager extends Object
    {
        private static var _like:Vector.<String> = new Vector.<String>;
        private static var _defaultAnimations:Vector.<String> = new Vector.<String>;

        public function SubstituteAnimationManager()
        {
            return;
        }// end function

        public static function setDefaultAnimation(param1:String, param2:String) : void
        {
            var _loc_3:* = _like.indexOf(param1);
            if (_loc_3 == -1)
            {
                _like.push(param1);
                _defaultAnimations.push(param2);
            }
            else
            {
                _defaultAnimations[_loc_3] = param2;
            }
            return;
        }// end function

        public static function getDefaultAnimation(param1:String) : String
        {
            var _loc_2:String = null;
            for each (_loc_2 in _like)
            {
                
                if (param1.indexOf(_loc_2) == 0)
                {
                    return _defaultAnimations[_like.indexOf(_loc_2)];
                }
            }
            return null;
        }// end function

    }
}
