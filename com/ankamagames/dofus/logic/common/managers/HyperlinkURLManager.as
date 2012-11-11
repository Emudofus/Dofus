package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import flash.net.*;

    public class HyperlinkURLManager extends Object
    {

        public function HyperlinkURLManager()
        {
            return;
        }// end function

        public static function openURL(param1:String) : void
        {
            navigateToURL(new URLRequest(param1), "_blank");
            return;
        }// end function

        public static function chatLinkRelease(param1:String, param2:uint, param3:String) : void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ChatLinkRelease, param1, param2, param3);
            return;
        }// end function

        public static function chatWarning() : void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ChatWarning);
            return;
        }// end function

    }
}
