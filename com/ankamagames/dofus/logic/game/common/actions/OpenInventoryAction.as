package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenInventoryAction extends Object implements Action
   {
      
      public function OpenInventoryAction() {
         super();
      }
      
      public static function create(param1:String="bag") : OpenInventoryAction {
         var _loc2_:OpenInventoryAction = new OpenInventoryAction();
         _loc2_.behavior = param1;
         return _loc2_;
      }
      
      public var behavior:String;
   }
}
