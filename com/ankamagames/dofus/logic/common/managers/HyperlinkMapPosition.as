package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.data.*;

    public class HyperlinkMapPosition extends Object
    {

        public function HyperlinkMapPosition()
        {
            return;
        }// end function

        public static function showPosition(param1:int, param2:int) : void
        {
            KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, "flag_chat", I18n.getUiText("ui.cartography.chatFlag") + " (" + param1 + "," + param2 + ")", param1, param2, 16737792, true);
            return;
        }// end function

        public static function getText(param1:int, param2:int) : String
        {
            return "[" + param1 + "," + param2 + "]";
        }// end function

    }
}
