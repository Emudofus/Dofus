package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.utils.crypto.*;

    public class HyperlinkAdminManager extends Object
    {

        public function HyperlinkAdminManager()
        {
            return;
        }// end function

        public static function addCmd(param1:String, param2:String) : void
        {
            KernelEventsManager.getInstance().processCallback(HookList.ConsoleAddCmd, param1.toLowerCase() == "true", Base64.decode(param2));
            return;
        }// end function

    }
}
