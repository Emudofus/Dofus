package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowAllNamesAction extends Object implements Action
   {
      
      public function ShowAllNamesAction() {
         super();
      }
      
      public static function create() : ShowAllNamesAction {
         var _loc1_:ShowAllNamesAction = new ShowAllNamesAction();
         return _loc1_;
      }
   }
}
