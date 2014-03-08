package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountSetXpRatioRequestAction extends Object implements Action
   {
      
      public function MountSetXpRatioRequestAction() {
         super();
      }
      
      public static function create(xpRatio:uint) : MountSetXpRatioRequestAction {
         var o:MountSetXpRatioRequestAction = new MountSetXpRatioRequestAction();
         o.xpRatio = xpRatio;
         return o;
      }
      
      public var xpRatio:uint;
   }
}
