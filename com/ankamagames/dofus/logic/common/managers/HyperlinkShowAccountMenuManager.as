package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;

    public class HyperlinkShowAccountMenuManager extends Object
    {

        public function HyperlinkShowAccountMenuManager()
        {
            return;
        }// end function

        public static function showAccountMenu(param1:String, param2:int) : void
        {
            var _loc_3:* = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            _loc_3.createContextMenu(MenusFactory.create({name:param1, id:param2}, "account"));
            return;
        }// end function

    }
}
