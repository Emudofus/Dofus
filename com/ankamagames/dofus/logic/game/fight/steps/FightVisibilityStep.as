package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.Sprite;
   
   public class FightVisibilityStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightVisibilityStep(param1:int, param2:Boolean) {
         super();
         this._fighterId = param1;
         this._visibility = param2;
      }
      
      private var _fighterId:int;
      
      private var _visibility:Boolean;
      
      public function get stepType() : String {
         return "visibility";
      }
      
      override public function start() : void {
         var _loc1_:Sprite = DofusEntities.getEntity(this._fighterId) as Sprite;
         if(_loc1_)
         {
            _loc1_.visible = this._visibility;
         }
         executeCallbacks();
      }
   }
}
