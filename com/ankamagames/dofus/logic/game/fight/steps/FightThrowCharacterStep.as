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
      
      public function FightThrowCharacterStep(param1:int, param2:int, param3:int) {
         super();
         this._fighterId = param1;
         this._carriedId = param2;
         this._cellId = param3;
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
         var _loc8_:GameFightFighterInformations = null;
         var _loc9_:FightTurnFrame = null;
         var _loc10_:Projectile = null;
         var _loc1_:DisplayObject = DofusEntities.getEntity(this._fighterId) as DisplayObject;
         var _loc2_:IEntity = _loc1_ as IEntity;
         _loc1_ = TiphonUtility.getEntityWithoutMount(_loc1_ as TiphonSprite);
         var _loc3_:IEntity = DofusEntities.getEntity(this._carriedId);
         if(!_loc3_)
         {
            _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
            this.throwFinished();
            return;
         }
         if(!_loc1_)
         {
            _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
            (_loc3_ as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
            if(_loc3_ is TiphonSprite)
            {
               (_loc3_ as TiphonSprite).setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
            this.throwFinished();
            return;
         }
         if(this._cellId != -1)
         {
            _loc8_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._carriedId) as GameFightFighterInformations;
            _loc8_.disposition.cellId = this._cellId;
         }
         if(this._carriedId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            _loc9_ = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(_loc9_)
            {
               _loc9_.freePlayer();
            }
         }
         var _loc4_:* = false;
         if(TiphonSprite(_loc3_).look.getBone() == 761)
         {
            _loc4_ = true;
         }
         _log.debug(this._fighterId + " is throwing " + this._carriedId + " (invisibility : " + _loc4_ + ")");
         if((_loc1_) && _loc1_ is TiphonSprite)
         {
            (_loc1_ as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
         }
         this._throwSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if(this._cellId == -1 || (_loc4_))
         {
            this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
            if(this._cellId == -1)
            {
               if(_loc1_ is TiphonSprite)
               {
                  this._throwSubSequence.addStep(new SetAnimationStep(_loc1_ as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
               }
               this.startSubSequence();
               return;
            }
         }
         var _loc5_:MapPoint = MapPoint.fromCellId(this._cellId);
         if(!_loc4_)
         {
            _loc3_.position = _loc5_;
         }
         var _loc6_:int = _loc2_.position.distanceToCell(_loc5_);
         var _loc7_:int = _loc2_.position.advancedOrientationTo(_loc5_);
         if(_loc1_ is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetDirectionStep((_loc1_ as TiphonSprite).rootEntity,_loc7_));
         }
         if(_loc6_ == 1)
         {
            _log.debug("Dropping nearby.");
            if(_loc1_ is TiphonSprite)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_ as TiphonSprite,AnimationEnum.ANIM_DROP,_loc4_,true,TiphonEvent.ANIMATION_END,1,_loc4_?AnimationEnum.ANIM_STATIQUE:""));
               }
               else
               {
                  this._throwSubSequence.addStep(new SetAnimationStep(_loc1_ as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
               }
            }
         }
         else
         {
            _log.debug("Throwing away.");
            if(_loc1_ is TiphonSprite)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_ as TiphonSprite,AnimationEnum.ANIM_THROW,_loc4_,true,TiphonEvent.ANIMATION_SHOT,1,_loc4_?AnimationEnum.ANIM_STATIQUE:""));
               }
               else
               {
                  (_loc3_ as TiphonSprite).visible = false;
               }
            }
            if(!_loc4_)
            {
               _loc10_ = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
               _loc10_.position = _loc2_.position.getNearestCellInDirection(_loc7_);
               this._throwSubSequence.addStep(new AddWorldEntityStep(_loc10_));
               this._throwSubSequence.addStep(new ParableGfxMovementStep(_loc10_,_loc5_,200,0.3,-70,true,1));
               this._throwSubSequence.addStep(new FightDestroyEntityStep(_loc10_));
            }
         }
         if(_loc4_)
         {
            this.startSubSequence();
            return;
         }
         this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
         this._throwSubSequence.addStep(new SetDirectionStep(_loc3_ as TiphonSprite,(_loc1_ as TiphonSprite).rootEntity.getDirection()));
         this._throwSubSequence.addStep(new AddWorldEntityStep(_loc3_));
         this._throwSubSequence.addStep(new SetAnimationStep(_loc3_ as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         if(_loc1_ is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetAnimationStep(_loc1_ as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         }
         this.startSubSequence();
      }
      
      private function startSubSequence() : void {
         this._throwSubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
         this._throwSubSequence.start();
      }
      
      private function throwFinished(param1:Event=null) : void {
         var _loc4_:DisplayObject = null;
         if(this._throwSubSequence)
         {
            this._throwSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
            this._throwSubSequence = null;
         }
         var _loc2_:DisplayObject = DofusEntities.getEntity(this._fighterId) as DisplayObject;
         if(_loc2_ is TiphonSprite)
         {
            _loc4_ = (_loc2_ as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
            if(_loc4_)
            {
               (_loc2_ as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
               _loc2_ = _loc4_;
            }
         }
         var _loc3_:IEntity = DofusEntities.getEntity(this._carriedId);
         if((_loc2_) && _loc2_ is TiphonSprite)
         {
            (_loc2_ as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
            (_loc2_ as TiphonSprite).removeSubEntity(_loc3_ as DisplayObject);
         }
         (_loc3_ as TiphonSprite).visible = true;
         if(_loc3_ is IMovable)
         {
            IMovable(_loc3_).movementBehavior.synchroniseSubEntitiesPosition(IMovable(_loc3_));
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
