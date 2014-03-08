package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class FightRemoveSubEntityStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightRemoveSubEntityStep(param1:int, param2:uint, param3:uint) {
         super();
         this._fighterId = param1;
         this._category = param2;
         this._slot = param3;
      }
      
      private var _fighterId:int;
      
      private var _category:uint;
      
      private var _slot:uint;
      
      public function get stepType() : String {
         return "removeSubEntity";
      }
      
      override public function start() : void {
         var _loc1_:IEntity = DofusEntities.getEntity(this._fighterId);
         if((_loc1_) && _loc1_ is TiphonSprite)
         {
            (_loc1_ as TiphonSprite).look.removeSubEntity(this._category,this._slot);
         }
         else
         {
            _log.warn("Unable to remove a subentity from fighter " + this._fighterId + ", non-existing or not a sprite.");
         }
         executeCallbacks();
      }
   }
}
