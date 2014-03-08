package gs
{
   import flash.errors.*;
   import flash.utils.*;
   
   public class OverwriteManager extends Object
   {
      
      public function OverwriteManager() {
         super();
      }
      
      public static const version:Number = 1;
      
      public static const NONE:int = 0;
      
      public static const ALL:int = 1;
      
      public static const AUTO:int = 2;
      
      public static const CONCURRENT:int = 3;
      
      public static var mode:int;
      
      public static var enabled:Boolean;
      
      public static function init(param1:int=2) : int {
         if(TweenLite.version < 9.29)
         {
            trace("TweenLite warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
         }
         TweenLite.overwriteManager = OverwriteManager;
         mode = param1;
         enabled = true;
         return mode;
      }
      
      public static function manageOverwrites(param1:TweenLite, param2:Array) : void {
         var _loc7_:* = 0;
         var _loc8_:TweenLite = null;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc3_:Object = param1.vars;
         var _loc4_:int = _loc3_.overwrite == undefined?mode:int(_loc3_.overwrite);
         if(_loc4_ < 2 || param2 == null)
         {
            return;
         }
         var _loc5_:Number = param1.startTime;
         var _loc6_:Array = [];
         _loc7_ = param2.length-1;
         while(_loc7_ > -1)
         {
            _loc8_ = param2[_loc7_];
            if(!(_loc8_ == param1) && _loc8_.startTime <= _loc5_ && _loc8_.startTime + _loc8_.duration * 1000 / _loc8_.combinedTimeScale > _loc5_)
            {
               _loc6_[_loc6_.length] = _loc8_;
            }
            _loc7_--;
         }
         if(_loc6_.length == 0)
         {
            return;
         }
         if(_loc4_ == AUTO)
         {
            if(_loc3_.isTV == true)
            {
               _loc3_ = _loc3_.exposedProps;
            }
            _loc9_ = {};
            for (_loc10_ in _loc3_)
            {
               if(!(_loc10_ == "ease" || _loc10_ == "delay" || _loc10_ == "overwrite" || _loc10_ == "onComplete" || _loc10_ == "onCompleteParams" || _loc10_ == "runBackwards" || _loc10_ == "persist" || _loc10_ == "onUpdate" || _loc10_ == "onUpdateParams" || _loc10_ == "timeScale" || _loc10_ == "onStart" || _loc10_ == "onStartParams" || _loc10_ == "renderOnStart" || _loc10_ == "proxiedEase" || _loc10_ == "easeParams" || _loc10_ == "onCompleteAll" || _loc10_ == "onCompleteAllParams" || _loc10_ == "yoyo" || _loc10_ == "loop" || _loc10_ == "onCompleteListener" || _loc10_ == "onStartListener" || _loc10_ == "onUpdateListener"))
               {
                  _loc9_[_loc10_] = 1;
                  if(_loc10_ == "shortRotate")
                  {
                     _loc9_.rotation = 1;
                  }
                  else
                  {
                     if(_loc10_ == "removeTint")
                     {
                        _loc9_.tint = 1;
                     }
                     else
                     {
                        if(_loc10_ == "autoAlpha")
                        {
                           _loc9_.alpha = 1;
                           _loc9_.visible = 1;
                        }
                     }
                  }
               }
            }
            _loc7_ = _loc6_.length-1;
            while(_loc7_ > -1)
            {
               _loc6_[_loc7_].killVars(_loc9_);
               _loc7_--;
            }
         }
         else
         {
            _loc7_ = _loc6_.length-1;
            while(_loc7_ > -1)
            {
               _loc6_[_loc7_].enabled = false;
               _loc7_--;
            }
         }
      }
      
      public static function killVars(param1:Object, param2:Object, param3:Array, param4:Array, param5:Array) : void {
         var _loc6_:* = 0;
         var _loc7_:String = null;
         _loc6_ = param4.length-1;
         while(_loc6_ > -1)
         {
            if(param1[param4[_loc6_].name] != undefined)
            {
               param4.splice(_loc6_,1);
            }
            _loc6_--;
         }
         _loc6_ = param3.length-1;
         while(_loc6_ > -1)
         {
            if(param1[param3[_loc6_][4]] != undefined)
            {
               param3.splice(_loc6_,1);
            }
            _loc6_--;
         }
         _loc6_ = param5.length-1;
         while(_loc6_ > -1)
         {
            if(param1[param5[_loc6_].name] != undefined)
            {
               param5.splice(_loc6_,1);
            }
            _loc6_--;
         }
         for (_loc7_ in param1)
         {
            delete param2[[_loc7_]];
         }
      }
   }
}
