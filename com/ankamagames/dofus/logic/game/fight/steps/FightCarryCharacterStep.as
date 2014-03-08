package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierSubEntityBehaviour;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import flash.events.Event;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   
   public class FightCarryCharacterStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightCarryCharacterStep(fighterId:int, carriedId:int, cellId:int=-1, noAnimation:Boolean=false) {
         super();
         this._fighterId = fighterId;
         this._carriedId = carriedId;
         this._cellId = cellId;
         this._noAnimation = noAnimation;
         this._isCreature = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).isInCreaturesFightMode();
      }
      
      static const CARRIED_SUBENTITY_CATEGORY:uint = 3;
      
      static const CARRIED_SUBENTITY_INDEX:uint = 0;
      
      private var _fighterId:int;
      
      private var _carriedId:int;
      
      private var _cellId:int;
      
      private var _carrySubSequence:ISequencer;
      
      private var _noAnimation:Boolean;
      
      private var _isCreature:Boolean;
      
      public function get stepType() : String {
         return "carryCharacter";
      }
      
      override public function start() : void {
         var carryingEntity2:TiphonSprite = null;
         var targetPosition:MapPoint = null;
         var cellEntities:Array = null;
         var carryingEntityOnCell:* = false;
         var carriedEntityOnCell:* = false;
         var cellEntity:TiphonSprite = null;
         var cEntity:IEntity = DofusEntities.getEntity(this._fighterId);
         var position:MapPoint = cEntity.position;
         var carryingEntity:TiphonSprite = cEntity as TiphonSprite;
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedId);
         if(((cEntity as AnimatedCharacter).isMounted()) && (!this._isCreature))
         {
            carryingEntity2 = carryingEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
            if(carryingEntity2 == null)
            {
               if(!carryingEntity.hasEventListener(TiphonEvent.SUB_ENTITY_ADDED))
               {
                  carryingEntity.addEventListener(TiphonEvent.SUB_ENTITY_ADDED,this.restart);
               }
               return;
            }
            carryingEntity2.isCarrying = true;
            carryingEntity2.carriedEntity = carriedEntity as TiphonSprite;
            carryingEntity = carryingEntity2;
         }
         if((!carryingEntity) || (!carriedEntity))
         {
            _log.warn("Unable to make " + this._fighterId + " carry " + this._carriedId + ", one of them is not in the stage.");
            this.carryFinished();
            return;
         }
         if((carryingEntity is TiphonSprite) && (carriedEntity is TiphonSprite) && (TiphonSprite(carriedEntity).parentSprite == carryingEntity))
         {
            this.updateCarriedEntityPosition(carryingEntity as IMovable,carriedEntity as IMovable);
            if((carryingEntity.rendered) && (carryingEntity.animationModifiers) && (carryingEntity.animationModifiers.length > 0))
            {
               carryingEntity.setAnimation(carryingEntity.getAnimation());
            }
            executeCallbacks();
            return;
         }
         var visible:Boolean = !FightEntitiesHolder.getInstance().getEntity(carriedEntity.id);
         this._carrySubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if(carryingEntity is TiphonSprite)
         {
            if(this._cellId == -1)
            {
               targetPosition = carriedEntity.position;
            }
            else
            {
               targetPosition = MapPoint.fromCellId(this._cellId);
            }
            if(targetPosition)
            {
               cellEntities = EntitiesManager.getInstance().getEntitiesOnCell(targetPosition.cellId);
               carryingEntityOnCell = false;
               carriedEntityOnCell = false;
               for each (cellEntity in cellEntities)
               {
                  if((cellEntity == carriedEntity) || (cellEntity.getSubEntitySlot(2,0) == carriedEntity))
                  {
                     carriedEntityOnCell = true;
                  }
                  if((cellEntity == carryingEntity) || (cellEntity.getSubEntitySlot(2,0) == carryingEntity))
                  {
                     carryingEntityOnCell = true;
                  }
               }
               if((!carryingEntityOnCell) && (!carriedEntityOnCell))
               {
                  this._carrySubSequence.addStep(new SetDirectionStep(carryingEntity.rootEntity,position.advancedOrientationTo(targetPosition)));
               }
               else
               {
                  this.updateCarriedEntityPosition(carryingEntity as IMovable,carriedEntity as IMovable);
               }
            }
         }
         var look:TiphonEntityLook = (carriedEntity as TiphonSprite).look;
         if(!visible)
         {
            look.resetSkins();
            look.setBone(761);
         }
         DisplayObject(carriedEntity).x = 0;
         DisplayObject(carriedEntity).y = 0;
         this._carrySubSequence.addStep(new FightAddSubEntityStep(this._fighterId,this._carriedId,CARRIED_SUBENTITY_CATEGORY,CARRIED_SUBENTITY_INDEX,new CarrierSubEntityBehaviour()));
         if(carryingEntity is TiphonSprite)
         {
            if((!this._noAnimation) && (!this._isCreature))
            {
               this._carrySubSequence.addStep(new PlayAnimationStep(carryingEntity as TiphonSprite,AnimationEnum.ANIM_PICKUP,false));
            }
            this._carrySubSequence.addStep(new SetAnimationStep(carryingEntity as TiphonSprite,this._isCreature?AnimationEnum.ANIM_STATIQUE:AnimationEnum.ANIM_STATIQUE_CARRYING));
         }
         this._carrySubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.carryFinished);
         this._carrySubSequence.start();
      }
      
      private function updateCarriedEntityPosition(pCarryingEntity:IMovable, pCarriedEntity:IMovable) : void {
         if((!pCarryingEntity) && ((DofusEntities.getEntity(this._fighterId) as AnimatedCharacter).isMounted()))
         {
            pCarryingEntity = DofusEntities.getEntity(this._fighterId) as IMovable;
         }
         if((pCarryingEntity) && (pCarriedEntity))
         {
            pCarriedEntity.position.x = pCarryingEntity.position.x;
            pCarriedEntity.position.y = pCarryingEntity.position.y;
            pCarriedEntity.position.cellId = pCarryingEntity.position.cellId;
         }
      }
      
      private function carryFinished(e:Event=null) : void {
         if(this._carrySubSequence)
         {
            this._carrySubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.carryFinished);
            this._carrySubSequence = null;
         }
         var carryingEntity:TiphonSprite = TiphonUtility.getEntityWithoutMount(DofusEntities.getEntity(this._fighterId) as TiphonSprite) as TiphonSprite;
         if((carryingEntity) && (carryingEntity is TiphonSprite) && (!this._isCreature))
         {
            (carryingEntity as TiphonSprite).addAnimationModifier(CarrierAnimationModifier.getInstance());
         }
         var carriedEntity:IEntity = DofusEntities.getEntity(this._carriedId);
         if(carriedEntity)
         {
            DisplayObject(carriedEntity).x = 0;
            DisplayObject(carriedEntity).y = 0;
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CARRY,[this._fighterId,this._carriedId],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      private function restart(pEvt:Event=null) : void {
         pEvt.currentTarget.removeEventListener(TiphonEvent.SUB_ENTITY_ADDED,this.restart);
         this.start();
      }
   }
}
