package com.ankamagames.jerakine.utils.system
{
   import flash.utils.Dictionary;


   public class CommandLineArguments extends Object
   {
         

      public function CommandLineArguments() {
         this._arguments=new Dictionary();
         super();
      }

      public static var _self:CommandLineArguments;

      public static function getInstance() : CommandLineArguments {
         if(!_self)
         {
            _self=new CommandLineArguments();
         }
         return _self;
      }

      private var _arguments:Dictionary;

      public function setArguments(args:Array) : void {
         var arg:String = null;
         var couple:Array = null;
         var key:String = null;
         if(args)
         {
            for each (arg in args)
            {
               couple=arg.split("=");
               key=couple[0].replace(new RegExp("^--?"),"");
               this._arguments[key]=couple[1];
            }
         }
      }

      public function hasArgument(argument:String) : Boolean {
         return this._arguments.hasOwnProperty(argument);
      }

      public function getArgument(argument:String) : String {
         return this._arguments[argument];
      }
   }

}