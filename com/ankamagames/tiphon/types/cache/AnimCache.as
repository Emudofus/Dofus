package com.ankamagames.tiphon.types.cache
{
    import __AS3__.vec.*;
    import com.ankamagames.tiphon.types.*;

    public class AnimCache extends Object
    {
        private var _directions:Vector.<Vector.<ScriptedAnimation>>;

        public function AnimCache()
        {
            this._directions = new Vector.<Vector.<ScriptedAnimation>>(8, true);
            this._directions[0] = new Vector.<ScriptedAnimation>;
            this._directions[1] = new Vector.<ScriptedAnimation>;
            this._directions[2] = new Vector.<ScriptedAnimation>;
            this._directions[6] = new Vector.<ScriptedAnimation>;
            this._directions[7] = new Vector.<ScriptedAnimation>;
            return;
        }// end function

        public function getAnimation(param1:int) : ScriptedAnimation
        {
            var _loc_2:int = 0;
            if (param1 == 3)
            {
                _loc_2 = 1;
            }
            else if (param1 == 4)
            {
                _loc_2 = 0;
            }
            else if (param1 == 5)
            {
                _loc_2 = 7;
            }
            else
            {
                _loc_2 = param1;
            }
            var _loc_3:* = this._directions[_loc_2];
            if (_loc_3.length)
            {
                return _loc_3.shift();
            }
            return null;
        }// end function

        public function pushAnimation(param1:ScriptedAnimation, param2:int) : void
        {
            var _loc_3:int = 0;
            if (param2 == 3)
            {
                _loc_3 = 1;
            }
            else if (param2 == 4)
            {
                _loc_3 = 0;
            }
            else if (param2 == 5)
            {
                _loc_3 = 7;
            }
            else
            {
                _loc_3 = param2;
            }
            this._directions[_loc_3].push(param1);
            return;
        }// end function

    }
}
