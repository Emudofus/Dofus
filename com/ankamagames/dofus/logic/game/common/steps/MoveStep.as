package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.scripts.ScriptsUtil;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   
   public class MoveStep extends AbstractSequencable
   {
      
      public function MoveStep(pEntity:AnimatedCharacter, pArgs:Array, pMovementBehavior:IMovementBehavior=null) {
         var i:* = 0;
         super();
         this._entity = pEntity;
         this._args = pArgs;
         if(pMovementBehavior)
         {
            this._behavior = pMovementBehavior;
         }
         this._allowDiag = true;
         while(i <= 6)
         {
            if((!this._entity.hasAnimation(AnimationEnum.ANIM_MARCHE,i)) || (!this._entity.hasAnimation(AnimationEnum.ANIM_COURSE,i)))
            {
               this._allowDiag = false;
               break;
            }
            i = i + 2;
         }
         timeout = 20000;
      }
      
      private var _entity:AnimatedCharacter;
      
      private var _args:Array;
      
      private var _behavior:IMovementBehavior;
      
      private var _allowDiag:Boolean;
      
      override public function start() : void {
         TooltipManager.hide("textBubble" + this._entity.id);
         TooltipManager.hide("smiley" + this._entity.id);
         if(this._entity.isMoving)
         {
            this._entity.stop();
         }
         Pathfinding.findPath(DataMapProvider.getInstance(),this._entity.position,ScriptsUtil.getMapPoint(this._args),this._allowDiag,true,this.onPath);
      }
      
      private function onPath(pPath:MovementPath) : void {
         if(this._behavior)
         {
            this._entity.movementBehavior = this._behavior;
            this._behavior.move(this._entity,pPath,this.onMovementEnd);
         }
         else
         {
            this._entity.move(pPath,this.onMovementEnd);
         }
      }
      
      private function onMovementEnd() : void {
         executeCallbacks();
      }
   }
}
