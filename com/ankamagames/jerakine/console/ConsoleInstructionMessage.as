package com.ankamagames.jerakine.console
{
    import com.ankamagames.jerakine.messages.*;

    public class ConsoleInstructionMessage extends Object implements Message
    {
        private var _cmd:String;
        private var _args:Array;
        private var _localCmd:Boolean;

        public function ConsoleInstructionMessage(param1:String, param2:Array)
        {
            this._localCmd = param1.charAt(0) == "/";
            this._cmd = param1.toLocaleLowerCase();
            if (this._localCmd)
            {
                this._cmd = this._cmd.substr(1);
            }
            this._args = param2;
            return;
        }// end function

        public function get cmd() : String
        {
            return this._cmd;
        }// end function

        public function get completCmd() : String
        {
            return (this._localCmd ? ("/") : ("")) + this._cmd;
        }// end function

        public function get args() : Array
        {
            return this._args;
        }// end function

        public function get isLocalCmd() : Boolean
        {
            return this._localCmd;
        }// end function

        public function equals(param1:ConsoleInstructionMessage) : Boolean
        {
            var _loc_2:Boolean = false;
            var _loc_3:uint = 0;
            _loc_2 = param1.completCmd == this.completCmd && this.args.length == param1.args.length;
            if (_loc_2)
            {
                _loc_3 = 0;
                while (_loc_3 < this.args.length)
                {
                    
                    _loc_2 = _loc_2 && this.args[_loc_3] == param1.args[_loc_3];
                    _loc_3 = _loc_3 + 1;
                }
            }
            return _loc_2;
        }// end function

    }
}
