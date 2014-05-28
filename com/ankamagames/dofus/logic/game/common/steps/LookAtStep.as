package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.scripts.ScriptsUtil;
   
   public class LookAtStep extends AbstractSequencable
   {
      
      public function LookAtStep(pEntity:AnimatedCharacter, pArgs:Array) {
         super();
         this._entity = pEntity;
         this._args = pArgs;
      }
      
      private var _entity:AnimatedCharacter;
      
      private var _args:Array;
      
      override public function start() : void {
         this._entity.setDirection(this._entity.position.advancedOrientationTo(ScriptsUtil.getMapPoint(this._args)));
         executeCallbacks();
      }
   }
}
