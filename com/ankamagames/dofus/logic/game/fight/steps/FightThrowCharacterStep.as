package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import flash.events.Event;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   
   public class FightThrowCharacterStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightThrowCharacterStep(fighterId:int, carriedId:int, cellId:int) {
         super();
         this._fighterId = fighterId;
         this._carriedId = carriedId;
         this._cellId = cellId;
         this._isCreature = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).isInCreaturesFightMode();
      }
      
      private static const THROWING_PROJECTILE_FX:uint = 21209;
      
      private var _fighterId:int;
      
      private var _carriedId:int;
      
      private var _cellId:int;
      
      private var _throwSubSequence:ISequencer;
      
      private var _isCreature:Boolean;
      
      public function get stepType() : String {
         return "throwCharacter";
      }
      
      override public function start() : void {
         var fighterInfos:GameFightFighterInformations = null;
         var fightTurnFrame:FightTurnFrame = null;
         var projectile:Projectile = null;
         var carryingEntity:DisplayObject = DofusEntities.getEntity(this._fighterId) as DisplayObject;
         var realCarryingEntity:IEntity = carryingEntity as IEntity;
         carryingEntity = TiphonUtility.getEntityWithoutMount(carryingEntity as TiphonSprite);
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedId);
         if(!carriedEntity)
         {
            _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
            this.throwFinished();
            return;
         }
         if(!carryingEntity)
         {
            _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
            (carriedEntity as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            if(carriedEntity is TiphonSprite)
            {
               (carriedEntity as TiphonSprite).setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
            this.throwFinished();
            return;
         }
         if(this._cellId != -1)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._carriedId) as GameFightFighterInformations;
            fighterInfos.disposition.cellId = this._cellId;
         }
         if(this._carriedId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(fightTurnFrame)
            {
               fightTurnFrame.freePlayer();
            }
         }
         var invisibility:Boolean = false;
         if(TiphonSprite(carriedEntity).look.getBone() == 761)
         {
            invisibility = true;
         }
         _log.debug(this._fighterId + " is throwing " + this._carriedId + " (invisibility : " + invisibility + ")");
         if((carryingEntity) && (carryingEntity is TiphonSprite))
         {
            (carryingEntity as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
         }
         this._throwSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if((this._cellId == -1) || (invisibility))
         {
            this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
            if(this._cellId == -1)
            {
               if(carryingEntity is TiphonSprite)
               {
                  this._throwSubSequence.addStep(new SetAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
               }
               this.startSubSequence();
               return;
            }
         }
         var targetCell:MapPoint = MapPoint.fromCellId(this._cellId);
         if(!invisibility)
         {
            carriedEntity.position = targetCell;
         }
         var targetDistance:int = realCarryingEntity.position.distanceToCell(targetCell);
         var targetDirection:int = realCarryingEntity.position.advancedOrientationTo(targetCell);
         if(carryingEntity is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetDirectionStep((carryingEntity as TiphonSprite).rootEntity,targetDirection));
         }
         if(targetDistance == 1)
         {
            _log.debug("Dropping nearby.");
            if(carryingEntity is TiphonSprite)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_DROP,invisibility,true,TiphonEvent.ANIMATION_END,1,invisibility?AnimationEnum.ANIM_STATIQUE:""));
               }
               else
               {
                  this._throwSubSequence.addStep(new SetAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
               }
            }
         }
         else
         {
            _log.debug("Throwing away.");
            if(carryingEntity is TiphonSprite)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_THROW,invisibility,true,TiphonEvent.ANIMATION_SHOT,1,invisibility?AnimationEnum.ANIM_STATIQUE:""));
               }
               else
               {
                  (carriedEntity as TiphonSprite).visible = false;
               }
            }
            if(!invisibility)
            {
               projectile = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
               projectile.position = realCarryingEntity.position.getNearestCellInDirection(targetDirection);
               this._throwSubSequence.addStep(new AddWorldEntityStep(projectile));
               this._throwSubSequence.addStep(new ParableGfxMovementStep(projectile,targetCell,200,0.3,-70,true,1));
               this._throwSubSequence.addStep(new FightDestroyEntityStep(projectile));
            }
         }
         if(invisibility)
         {
            this.startSubSequence();
            return;
         }
         this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
         this._throwSubSequence.addStep(new SetDirectionStep(carriedEntity as TiphonSprite,(carryingEntity as TiphonSprite).rootEntity.getDirection()));
         this._throwSubSequence.addStep(new AddWorldEntityStep(carriedEntity));
         this._throwSubSequence.addStep(new SetAnimationStep(carriedEntity as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         if(carryingEntity is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         }
         this.startSubSequence();
      }
      
      private function startSubSequence() : void {
         this._throwSubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
         this._throwSubSequence.start();
      }
      
      private function throwFinished(e:Event = null) : void {
         var rider:DisplayObject = null;
         if(this._throwSubSequence)
         {
            this._throwSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
            this._throwSubSequence = null;
         }
         var carryingEntity:DisplayObject = DofusEntities.getEntity(this._fighterId) as DisplayObject;
         if(carryingEntity is TiphonSprite)
         {
            rider = (carryingEntity as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
            if(rider)
            {
               (carryingEntity as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
               carryingEntity = rider;
            }
         }
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedId);
         if((carryingEntity) && (carryingEntity is TiphonSprite))
         {
            (carryingEntity as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
            (carryingEntity as TiphonSprite).removeSubEntity(carriedEntity as DisplayObject);
         }
         (carriedEntity as TiphonSprite).visible = true;
         if(carriedEntity is IMovable)
         {
            IMovable(carriedEntity).movementBehavior.synchroniseSubEntitiesPosition(IMovable(carriedEntity));
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_THROW,[this._fighterId,this._carriedId,this._cellId],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      override public function toString() : String {
         return "[FightThrowCharacterStep(carrier=" + this._fighterId + ", carried=" + this._carriedId + ", cell=" + this._cellId + ")]";
      }
   }
}
