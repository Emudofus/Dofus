package com.ankamagames.jerakine.utils.system
{
    import flash.utils.*;

    public class CommandLineArguments extends Object
    {
        private var _arguments:Dictionary;
        public static var _self:CommandLineArguments;

        public function CommandLineArguments()
        {
            this._arguments = new Dictionary();
            return;
        }// end function

        public function setArguments(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1)
            {
                for each (_loc_2 in param1)
                {
                    
                    _loc_3 = _loc_2.split("=");
                    _loc_4 = _loc_3[0].replace(/^--?""^--?/, "");
                    this._arguments[_loc_4] = _loc_3[1];
                }
            }
            return;
        }// end function

        public function hasArgument(param1:String) : Boolean
        {
            return this._arguments.hasOwnProperty(param1);
        }// end function

        public function getArgument(param1:String) : String
        {
            return this._arguments[param1];
        }// end function

        public static function getInstance() : CommandLineArguments
        {
            if (!_self)
            {
                _self = new CommandLineArguments;
            }
            return _self;
        }// end function

    }
}
