package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.utils.misc.*;

    public class HyperlinkSendHookManager extends Object
    {

        public function HyperlinkSendHookManager()
        {
            return;
        }// end function

        public static function sendHook(param1:String, ... args) : void
        {
            args = Hook.getHookByName(param1);
            if (!args)
            {
                throw new ApiError("Hook [" + param1 + "] does not exist");
            }
            if (args.nativeHook)
            {
                throw new UntrustedApiCallError("Hook " + param1 + " is a native hook. Native hooks cannot be dispatch by module");
            }
            CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(args).concat(args));
            return;
        }// end function

    }
}
