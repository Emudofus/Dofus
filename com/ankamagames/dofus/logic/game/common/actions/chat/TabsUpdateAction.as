package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TabsUpdateAction implements Action 
    {

        public var tabs:Array;
        public var tabsNames:Array;


        public static function create(tabs:Array=null, tabsNames:Array=null):TabsUpdateAction
        {
            var a:TabsUpdateAction = new (TabsUpdateAction)();
            a.tabs = tabs;
            a.tabsNames = tabsNames;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

