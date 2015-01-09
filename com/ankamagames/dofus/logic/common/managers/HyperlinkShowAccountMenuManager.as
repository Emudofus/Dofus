package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.factories.MenusFactory;

    public class HyperlinkShowAccountMenuManager 
    {


        public static function showAccountMenu(accountName:String, accountId:int):void
        {
            var _modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            _modContextMenu.createContextMenu(MenusFactory.create({
                "name":accountName,
                "id":accountId
            }, "account"));
        }


    }
}//package com.ankamagames.dofus.logic.common.managers

