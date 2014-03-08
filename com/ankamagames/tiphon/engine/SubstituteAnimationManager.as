package com.ankamagames.tiphon.engine
{
   import __AS3__.vec.Vector;
   
   public final class SubstituteAnimationManager extends Object
   {
      
      public function SubstituteAnimationManager() {
         super();
      }
      
      private static var _like:Vector.<String> = new Vector.<String>();
      
      private static var _defaultAnimations:Vector.<String> = new Vector.<String>();
      
      public static function setDefaultAnimation(param1:String, param2:String) : void {
         var _loc3_:int = _like.indexOf(param1);
         if(_loc3_ == -1)
         {
            _like.push(param1);
            _defaultAnimations.push(param2);
         }
         else
         {
            _defaultAnimations[_loc3_] = param2;
         }
      }
      
      public static function getDefaultAnimation(param1:String) : String {
         var _loc2_:String = null;
         for each (_loc2_ in _like)
         {
            if(param1.indexOf(_loc2_) == 0)
            {
               return _defaultAnimations[_like.indexOf(_loc2_)];
            }
         }
         return null;
      }
   }
}
