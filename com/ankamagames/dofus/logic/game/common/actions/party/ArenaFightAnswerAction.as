package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaFightAnswerAction extends Object implements Action
   {
      
      public function ArenaFightAnswerAction() {
         super();
      }
      
      public static function create(param1:uint, param2:Boolean) : ArenaFightAnswerAction {
         var _loc3_:ArenaFightAnswerAction = new ArenaFightAnswerAction();
         _loc3_.fightId = param1;
         _loc3_.accept = param2;
         return _loc3_;
      }
      
      public var fightId:uint;
      
      public var accept:Boolean;
   }
}
