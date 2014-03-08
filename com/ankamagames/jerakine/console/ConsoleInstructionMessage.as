package com.ankamagames.jerakine.console
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ConsoleInstructionMessage extends Object implements Message
   {
      
      public function ConsoleInstructionMessage(param1:String, param2:Array) {
         super();
         this._localCmd = param1.charAt(0) == "/";
         this._cmd = param1.toLocaleLowerCase();
         if(this._localCmd)
         {
            this._cmd = this._cmd.substr(1);
         }
         this._args = param2;
      }
      
      private var _cmd:String;
      
      private var _args:Array;
      
      private var _localCmd:Boolean;
      
      public function get cmd() : String {
         return this._cmd;
      }
      
      public function get completCmd() : String {
         return (this._localCmd?"/":"") + this._cmd;
      }
      
      public function get args() : Array {
         return this._args;
      }
      
      public function get isLocalCmd() : Boolean {
         return this._localCmd;
      }
      
      public function equals(param1:ConsoleInstructionMessage) : Boolean {
         var _loc2_:* = false;
         var _loc3_:uint = 0;
         _loc2_ = param1.completCmd == this.completCmd && this.args.length == param1.args.length;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < this.args.length)
            {
               _loc2_ = (_loc2_) && this.args[_loc3_] == param1.args[_loc3_];
               _loc3_++;
            }
         }
         return _loc2_;
      }
   }
}
