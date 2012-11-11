package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;

    public class HyperlinkSocialManager extends Object
    {

        public function HyperlinkSocialManager()
        {
            return;
        }// end function

        public static function openSocial(param1:int, param2:int) : void
        {
            KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, param1, param2);
            return;
        }// end function

    }
}
