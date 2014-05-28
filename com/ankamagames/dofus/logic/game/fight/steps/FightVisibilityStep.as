package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.Sprite;
   
   public class FightVisibilityStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightVisibilityStep(fighterId:int, visibility:Boolean) {
         super();
         this._fighterId = fighterId;
         this._visibility = visibility;
      }
      
      private var _fighterId:int;
      
      private var _visibility:Boolean;
      
      public function get stepType() : String {
         return "visibility";
      }
      
      override public function start() : void {
         var summonedCreature:Sprite = DofusEntities.getEntity(this._fighterId) as Sprite;
         if(summonedCreature)
         {
            summonedCreature.visible = this._visibility;
         }
         executeCallbacks();
      }
   }
}
