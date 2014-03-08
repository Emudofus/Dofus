package com.ankamagames.berilia.api
{
   import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
   import com.ankamagames.berilia.managers.SecureCenter;
   
   public class GenericApiFunction extends Object
   {
      
      public function GenericApiFunction() {
         super();
      }
      
      public static function throwUntrustedCallError(... rest) : void {
         throw new UntrustedApiCallError("Unstrusted script called a trusted method");
      }
      
      public static function getRestrictedFunctionAccess(param1:Function) : Function {
         var target:Function = param1;
         return function(... rest):*
         {
            var _loc4_:* = undefined;
            var _loc2_:* = SecureCenter.ACCESS_KEY;
            var _loc3_:* = 0;
            for each (_loc4_ in rest)
            {
               if(_loc4_ == _loc2_)
               {
                  rest.splice(_loc3_,1);
                  return target.apply(null,rest);
               }
               _loc3_++;
            }
            throw new UntrustedApiCallError("Unstrusted script called a trusted method");
         };
      }
   }
}
