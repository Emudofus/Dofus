package com.ankamagames.dofus.logic.game.common.managers
{

    public class FlagManager extends Object
    {
        private var _phoenixs:Array;
        private static var _self:FlagManager;

        public function FlagManager()
        {
            this._phoenixs = new Array();
            return;
        }// end function

        public function get phoenixs() : Array
        {
            return this._phoenixs;
        }// end function

        public function set phoenixs(param1:Array) : void
        {
            this._phoenixs = param1;
            return;
        }// end function

        public static function getInstance() : FlagManager
        {
            if (!_self)
            {
                _self = new FlagManager;
            }
            return _self;
        }// end function

    }
}
