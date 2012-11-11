package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class FightersStateManager extends Object
    {
        private var _entityStates:Dictionary;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightersStateManager));
        private static var _self:FightersStateManager;

        public function FightersStateManager()
        {
            this._entityStates = new Dictionary();
            return;
        }// end function

        public function addStateOnTarget(param1:int, param2:int) : void
        {
            var _loc_3:* = this._entityStates[param2];
            if (!_loc_3)
            {
                _loc_3 = new Array();
                this._entityStates[param2] = _loc_3;
            }
            if (_loc_3.indexOf(param1) == -1)
            {
                _loc_3.push(param1);
            }
            return;
        }// end function

        public function removeStateOnTarget(param1:int, param2:int) : void
        {
            var _loc_3:* = this._entityStates[param2];
            if (!_loc_3)
            {
                _log.error("Can\'t find state list for " + param2 + " to remove state");
                return;
            }
            var _loc_4:* = _loc_3.indexOf(param1);
            if (_loc_3.indexOf(param1) != -1)
            {
                _loc_3.splice(_loc_4, 1);
            }
            return;
        }// end function

        public function hasState(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = this._entityStates[param1];
            if (!_loc_3)
            {
                return false;
            }
            return _loc_3.indexOf(param2) != -1;
        }// end function

        public function getStates(param1:int) : Array
        {
            return this._entityStates[param1];
        }// end function

        public function endFight() : void
        {
            this._entityStates = new Dictionary();
            return;
        }// end function

        public static function getInstance() : FightersStateManager
        {
            if (!_self)
            {
                _self = new FightersStateManager;
            }
            return _self;
        }// end function

    }
}
