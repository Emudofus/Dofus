package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobAllowMultiCraftRequestSetAction extends Object implements Action
   {
      
      public function JobAllowMultiCraftRequestSetAction() {
         super();
      }
      
      public static function create(param1:Boolean) : JobAllowMultiCraftRequestSetAction {
         var _loc2_:JobAllowMultiCraftRequestSetAction = new JobAllowMultiCraftRequestSetAction();
         _loc2_.isPublic = param1;
         return _loc2_;
      }
      
      public var isPublic:Boolean;
   }
}
