package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TabsUpdateAction extends Object implements Action
   {
      
      public function TabsUpdateAction() {
         super();
      }
      
      public static function create(tabs:Array = null, tabsNames:Array = null) : TabsUpdateAction {
         var a:TabsUpdateAction = new TabsUpdateAction();
         a.tabs = tabs;
         a.tabsNames = tabsNames;
         return a;
      }
      
      public var tabs:Array;
      
      public var tabsNames:Array;
   }
}
