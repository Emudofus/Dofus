package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountSetXpRatioRequestAction extends Object implements Action
   {
      
      public function MountSetXpRatioRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : MountSetXpRatioRequestAction {
         var _loc2_:MountSetXpRatioRequestAction = new MountSetXpRatioRequestAction();
         _loc2_.xpRatio = param1;
         return _loc2_;
      }
      
      public var xpRatio:uint;
   }
}
