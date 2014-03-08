package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BannerEmptySlotClickAction extends Object implements Action
   {
      
      public function BannerEmptySlotClickAction() {
         super();
      }
      
      public static function create() : BannerEmptySlotClickAction {
         var _loc1_:BannerEmptySlotClickAction = new BannerEmptySlotClickAction();
         return _loc1_;
      }
   }
}
