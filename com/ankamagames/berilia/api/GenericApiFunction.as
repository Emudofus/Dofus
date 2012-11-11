package com.ankamagames.berilia.api
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.utils.errors.*;

    public class GenericApiFunction extends Object
    {

        public function GenericApiFunction()
        {
            return;
        }// end function

        public static function throwUntrustedCallError(... args) : void
        {
            throw new UntrustedApiCallError("Unstrusted script called a trusted method");
        }// end function

        public static function getRestrictedFunctionAccess(param1:Function) : Function
        {
            var target:* = param1;
            return function (... args)
            {
                var _loc_4:* = undefined;
                args = SecureCenter.ACCESS_KEY;
                var _loc_3:* = 0;
                for each (_loc_4 in args)
                {
                    
                    if (_loc_4 == args)
                    {
                        args.splice(_loc_3, 1);
                        return target.apply(null, args);
                    }
                    _loc_3 = _loc_3 + 1;
                }
                throw new UntrustedApiCallError("Unstrusted script called a trusted method");
            }// end function
            ;
        }// end function

    }
}
