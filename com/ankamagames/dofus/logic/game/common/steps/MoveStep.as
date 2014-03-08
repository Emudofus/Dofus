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
      
      public function MoveStep(param1:AnimatedCharacter, param2:Array, param3:IMovementBehavior=null) {
         var _loc4_:* = 0;
         super();
         this._entity = param1;
         this._args = param2;
         if(param3)
         {
            this._behavior = param3;
         }
         this._allowDiag = true;
         while(_loc4_ <= 6)
         {
            if(!this._entity.hasAnimation(AnimationEnum.ANIM_MARCHE,_loc4_) || !this._entity.hasAnimation(AnimationEnum.ANIM_COURSE,_loc4_))
            {
               this._allowDiag = false;
               break;
            }
            _loc4_ = _loc4_ + 2;
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
      
      private function onPath(param1:MovementPath) : void {
         if(this._behavior)
         {
            this._entity.movementBehavior = this._behavior;
            this._behavior.move(this._entity,param1,this.onMovementEnd);
         }
         else
         {
            this._entity.move(param1,this.onMovementEnd);
         }
      }
      
      private function onMovementEnd() : void {
         executeCallbacks();
      }
   }
}
