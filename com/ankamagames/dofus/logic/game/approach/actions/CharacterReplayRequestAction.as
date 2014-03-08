package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterReplayRequestAction extends Object implements Action
   {
      
      public function CharacterReplayRequestAction() {
         super();
      }
      
      public static function create(characterId:uint) : CharacterReplayRequestAction {
         var a:CharacterReplayRequestAction = new CharacterReplayRequestAction();
         a.characterId = characterId;
         return a;
      }
      
      public var characterId:uint;
   }
}
