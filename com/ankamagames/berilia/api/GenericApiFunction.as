package com.ankamagames.berilia.api
{
   import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
   import com.ankamagames.berilia.managers.SecureCenter;
   
   public class GenericApiFunction extends Object
   {
      
      public function GenericApiFunction() {
         super();
      }
      
      public static function throwUntrustedCallError(... args) : void {
         throw new UntrustedApiCallError("Unstrusted script called a trusted method");
      }
      
      public static function getRestrictedFunctionAccess(target:Function) : Function {
         return function(... args):*
         {
            var arg:* = undefined;
            var accessKey:* = SecureCenter.ACCESS_KEY;
            var i:* = 0;
            for each (arg in args)
            {
               if(arg == accessKey)
               {
                  args.splice(i,1);
                  return target.apply(null,args);
               }
               i++;
            }
            throw new UntrustedApiCallError("Unstrusted script called a trusted method");
         };
      }
   }
}
