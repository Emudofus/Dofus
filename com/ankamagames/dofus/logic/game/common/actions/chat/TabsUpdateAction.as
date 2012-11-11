package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TabsUpdateAction extends Object implements Action
    {
        public var tabs:Array;
        public var tabsNames:Array;

        public function TabsUpdateAction()
        {
            return;
        }// end function

        public static function create(param1:Array = null, param2:Array = null) : TabsUpdateAction
        {
            var _loc_3:* = new TabsUpdateAction;
            _loc_3.tabs = param1;
            _loc_3.tabsNames = param2;
            return _loc_3;
        }// end function

    }
}
