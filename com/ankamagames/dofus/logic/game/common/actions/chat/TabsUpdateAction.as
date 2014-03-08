package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TabsUpdateAction extends Object implements Action
   {
      
      public function TabsUpdateAction() {
         super();
      }
      
      public static function create(param1:Array=null, param2:Array=null) : TabsUpdateAction {
         var _loc3_:TabsUpdateAction = new TabsUpdateAction();
         _loc3_.tabs = param1;
         _loc3_.tabsNames = param2;
         return _loc3_;
      }
      
      public var tabs:Array;
      
      public var tabsNames:Array;
   }
}
