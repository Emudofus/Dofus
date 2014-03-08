package com.ankamagames.dofus.types.data
{
   public class ServerCommand extends Object
   {
      
      public function ServerCommand(param1:String, param2:String) {
         super();
         this.name = param1;
         this.help = param2;
         if(!_cmdByName[param1])
         {
            _cmdByName[param1] = this;
            _cmdList.push(param1);
         }
      }
      
      private static var _cmdList:Array = [];
      
      private static var _cmdByName:Array = [];
      
      public static function get commandList() : Array {
         return _cmdList;
      }
      
      public static function autoComplete(param1:String) : String {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc6_:uint = 0;
         var _loc2_:Array = new Array();
         for (_loc3_ in _cmdByName)
         {
            if(_loc3_.indexOf(param1) == 0)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length > 1)
         {
            _loc4_ = "";
            _loc5_ = true;
            _loc6_ = 1;
            while(_loc6_ < 30)
            {
               if(_loc6_ > _loc2_[0].length)
               {
                  break;
               }
               for each (_loc3_ in _loc2_)
               {
                  _loc5_ = (_loc5_) && _loc3_.indexOf(_loc2_[0].substr(0,_loc6_)) == 0;
                  if(!_loc5_)
                  {
                     break;
                  }
               }
               if(_loc5_)
               {
                  _loc4_ = _loc2_[0].substr(0,_loc6_);
                  _loc6_++;
                  continue;
               }
               break;
            }
            return _loc4_;
         }
         return _loc2_[0];
      }
      
      public static function getAutoCompletePossibilities(param1:String) : Array {
         var _loc3_:String = null;
         var _loc2_:Array = new Array();
         for (_loc3_ in _cmdByName)
         {
            if(_loc3_.indexOf(param1) == 0)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getHelp(param1:String) : String {
         return _cmdByName[param1]?_cmdByName[param1].help:null;
      }
      
      public static function hasCommand(param1:String) : Boolean {
         return _cmdByName.hasOwnProperty(param1);
      }
      
      public var name:String;
      
      public var help:String;
   }
}
