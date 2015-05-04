package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.types.positions.MapPoint;
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
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   
   public class FightThrowCharacterStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightThrowCharacterStep(param1:int, param2:int, param3:int)
      {
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
      
      public var portals:Vector.<MapPoint>;
      
      public var portalIds:Vector.<int>;
      
      public function get stepType() : String
      {
         return "throwCharacter";
      }
      
      override public function start() : void
      {
         var _loc9_:GameFightFighterInformations = null;
         var _loc10_:FightTurnFrame = null;
         var _loc11_:MapPoint = null;
         var _loc12_:MapPoint = null;
         var _loc13_:Projectile = null;
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
            _loc9_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._carriedId) as GameFightFighterInformations;
            _loc9_.disposition.cellId = this._cellId;
         }
         if(this._carriedId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            _loc10_ = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(_loc10_)
            {
               _loc10_.freePlayer();
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
         if((this.portals) && this.portals.length > 1)
         {
            _loc11_ = this.portals[0];
            _loc12_ = this.portals[this.portals.length - 1];
         }
         var _loc5_:MapPoint = MapPoint.fromCellId(this._cellId);
         var _loc6_:MapPoint = _loc11_ != null?_loc11_:_loc5_;
         var _loc7_:int = _loc2_.position.distanceToCell(_loc6_);
         var _loc8_:int = _loc2_.position.advancedOrientationTo(_loc6_);
         if(!_loc4_)
         {
            _loc3_.position = _loc5_;
         }
         if(_loc1_ is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetDirectionStep((_loc1_ as TiphonSprite).rootEntity,_loc8_));
         }
         if(_loc7_ == 1)
         {
            _log.debug("Dropping nearby.");
            if(_loc1_ is TiphonSprite)
            {
               if(!this._isCreature)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_ as TiphonSprite,AnimationEnum.ANIM_DROP,_loc4_,true,TiphonEvent.ANIMATION_END,1,_loc4_?AnimationEnum.ANIM_STATIQUE:""));
                  if(_loc11_)
                  {
                     this.addCleanEntitiesSteps(_loc3_,_loc1_,false);
                     this.addPortalAnimationSteps();
                     _loc13_ = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
                     _loc13_.position = _loc12_;
                     this._throwSubSequence.addStep(new AddWorldEntityStep(_loc13_));
                     this._throwSubSequence.addStep(new ParableGfxMovementStep(_loc13_,_loc5_,200,0.3,-70,true,1));
                     this._throwSubSequence.addStep(new FightDestroyEntityStep(_loc13_));
                  }
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
               _loc13_ = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
               _loc13_.position = _loc2_.position.getNearestCellInDirection(_loc8_);
               this._throwSubSequence.addStep(new AddWorldEntityStep(_loc13_));
               this._throwSubSequence.addStep(new ParableGfxMovementStep(_loc13_,_loc6_,200,0.3,-70,true,1));
               this._throwSubSequence.addStep(new FightDestroyEntityStep(_loc13_));
               if(_loc12_)
               {
                  this.addCleanEntitiesSteps(_loc3_,_loc1_,false);
                  this.addPortalAnimationSteps();
                  _loc13_ = new Projectile(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
                  _loc13_.position = _loc12_;
                  this._throwSubSequence.addStep(new AddWorldEntityStep(_loc13_));
                  this._throwSubSequence.addStep(new ParableGfxMovementStep(_loc13_,_loc5_,200,0.3,-70,true,1));
                  this._throwSubSequence.addStep(new FightDestroyEntityStep(_loc13_));
               }
            }
         }
         if(_loc4_)
         {
            this.startSubSequence();
            return;
         }
         if(_loc11_)
         {
            this._throwSubSequence.addStep(new AddWorldEntityStep(_loc3_));
         }
         else
         {
            this.addCleanEntitiesSteps(_loc3_,_loc1_,true);
         }
         this.startSubSequence();
      }
      
      private function startSubSequence() : void
      {
         this._throwSubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.throwFinished);
         this._throwSubSequence.start();
      }
      
      private function throwFinished(param1:Event = null) : void
      {
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
      
      private function addCleanEntitiesSteps(param1:IEntity, param2:DisplayObject, param3:Boolean) : void
      {
         this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId,this._carriedId,FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY,FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
         this._throwSubSequence.addStep(new SetDirectionStep(param1 as TiphonSprite,(param2 as TiphonSprite).rootEntity.getDirection()));
         if(param3)
         {
            this._throwSubSequence.addStep(new AddWorldEntityStep(param1));
         }
         this._throwSubSequence.addStep(new SetAnimationStep(param1 as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         if(param2 is TiphonSprite)
         {
            this._throwSubSequence.addStep(new SetAnimationStep(param2 as TiphonSprite,AnimationEnum.ANIM_STATIQUE));
         }
      }
      
      private function addPortalAnimationSteps() : void
      {
         var _loc1_:Glyph = MarkedCellsManager.getInstance().getGlyph(this.portalIds[0]);
         if(_loc1_)
         {
            if(_loc1_.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
            {
               this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_,PortalAnimationEnum.STATE_NORMAL,false,false));
            }
            this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_,PortalAnimationEnum.STATE_ENTRY_SPELL,false,true,TiphonEvent.ANIMATION_SHOT));
         }
         var _loc2_:* = 1;
         while(_loc2_ < this.portalIds.length - 1)
         {
            _loc1_ = MarkedCellsManager.getInstance().getGlyph(this.portalIds[_loc2_]);
            if(_loc1_)
            {
               if(_loc1_.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
               {
                  this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_,PortalAnimationEnum.STATE_NORMAL,false,false));
               }
               this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_,PortalAnimationEnum.STATE_ENTRY_SPELL,false,true,TiphonEvent.ANIMATION_SHOT));
            }
            _loc2_++;
         }
         _loc1_ = MarkedCellsManager.getInstance().getGlyph(this.portalIds[this.portalIds.length - 1]);
         if(_loc1_)
         {
            if(_loc1_.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
            {
               this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_,PortalAnimationEnum.STATE_NORMAL,false,false));
            }
            this._throwSubSequence.addStep(new PlayAnimationStep(_loc1_,PortalAnimationEnum.STATE_EXIT_SPELL,false,false));
         }
      }
      
      override public function toString() : String
      {
         return "[FightThrowCharacterStep(carrier=" + this._fighterId + ", carried=" + this._carriedId + ", cell=" + this._cellId + ")]";
      }
   }
}
