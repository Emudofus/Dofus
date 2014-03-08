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
      
      public function FightCarryCharacterStep(param1:int, param2:int, param3:int=-1, param4:Boolean=false) {
         super();
         this._fighterId = param1;
         this._carriedId = param2;
         this._cellId = param3;
         this._noAnimation = param4;
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
         var _loc7_:TiphonSprite = null;
         var _loc8_:MapPoint = null;
         var _loc9_:Array = null;
         var _loc10_:* = false;
         var _loc11_:* = false;
         var _loc12_:TiphonSprite = null;
         var _loc1_:IEntity = DofusEntities.getEntity(this._fighterId);
         var _loc2_:MapPoint = _loc1_.position;
         var _loc3_:TiphonSprite = _loc1_ as TiphonSprite;
         var _loc4_:IEntity = DofusEntities.getEntity(this._carriedId);
         if(((_loc1_ as AnimatedCharacter).isMounted()) && !this._isCreature)
         {
            _loc7_ = _loc3_.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
            if(_loc7_ == null)
            {
               if(!_loc3_.hasEventListener(TiphonEvent.SUB_ENTITY_ADDED))
               {
                  _loc3_.addEventListener(TiphonEvent.SUB_ENTITY_ADDED,this.restart);
               }
               return;
            }
            _loc7_.isCarrying = true;
            _loc7_.carriedEntity = _loc4_ as TiphonSprite;
            _loc3_ = _loc7_;
         }
         if(!_loc3_ || !_loc4_)
         {
            _log.warn("Unable to make " + this._fighterId + " carry " + this._carriedId + ", one of them is not in the stage.");
            this.carryFinished();
            return;
         }
         if(_loc3_ is TiphonSprite && _loc4_ is TiphonSprite && TiphonSprite(_loc4_).parentSprite == _loc3_)
         {
            this.updateCarriedEntityPosition(_loc3_ as IMovable,_loc4_ as IMovable);
            if((_loc3_.rendered) && (_loc3_.animationModifiers) && _loc3_.animationModifiers.length > 0)
            {
               _loc3_.setAnimation(_loc3_.getAnimation());
            }
            executeCallbacks();
            return;
         }
         var _loc5_:* = !FightEntitiesHolder.getInstance().getEntity(_loc4_.id);
         this._carrySubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
         if(_loc3_ is TiphonSprite)
         {
            if(this._cellId == -1)
            {
               _loc8_ = _loc4_.position;
            }
            else
            {
               _loc8_ = MapPoint.fromCellId(this._cellId);
            }
            if(_loc8_)
            {
               _loc9_ = EntitiesManager.getInstance().getEntitiesOnCell(_loc8_.cellId);
               _loc10_ = false;
               _loc11_ = false;
               for each (_loc12_ in _loc9_)
               {
                  if(_loc12_ == _loc4_ || _loc12_.getSubEntitySlot(2,0) == _loc4_)
                  {
                     _loc11_ = true;
                  }
                  if(_loc12_ == _loc3_ || _loc12_.getSubEntitySlot(2,0) == _loc3_)
                  {
                     _loc10_ = true;
                  }
               }
               if(!_loc10_ && !_loc11_)
               {
                  this._carrySubSequence.addStep(new SetDirectionStep(_loc3_.rootEntity,_loc2_.advancedOrientationTo(_loc8_)));
               }
               else
               {
                  this.updateCarriedEntityPosition(_loc3_ as IMovable,_loc4_ as IMovable);
               }
            }
         }
         var _loc6_:TiphonEntityLook = (_loc4_ as TiphonSprite).look;
         if(!_loc5_)
         {
            _loc6_.resetSkins();
            _loc6_.setBone(761);
         }
         DisplayObject(_loc4_).x = 0;
         DisplayObject(_loc4_).y = 0;
         this._carrySubSequence.addStep(new FightAddSubEntityStep(this._fighterId,this._carriedId,CARRIED_SUBENTITY_CATEGORY,CARRIED_SUBENTITY_INDEX,new CarrierSubEntityBehaviour()));
         if(_loc3_ is TiphonSprite)
         {
            if(!this._noAnimation && !this._isCreature)
            {
               this._carrySubSequence.addStep(new PlayAnimationStep(_loc3_ as TiphonSprite,AnimationEnum.ANIM_PICKUP,false));
            }
            this._carrySubSequence.addStep(new SetAnimationStep(_loc3_ as TiphonSprite,this._isCreature?AnimationEnum.ANIM_STATIQUE:AnimationEnum.ANIM_STATIQUE_CARRYING));
         }
         this._carrySubSequence.addEventListener(SequencerEvent.SEQUENCE_END,this.carryFinished);
         this._carrySubSequence.start();
      }
      
      private function updateCarriedEntityPosition(param1:IMovable, param2:IMovable) : void {
         if(!param1 && ((DofusEntities.getEntity(this._fighterId) as AnimatedCharacter).isMounted()))
         {
            param1 = DofusEntities.getEntity(this._fighterId) as IMovable;
         }
         if((param1) && (param2))
         {
            param2.position.x = param1.position.x;
            param2.position.y = param1.position.y;
            param2.position.cellId = param1.position.cellId;
         }
      }
      
      private function carryFinished(param1:Event=null) : void {
         if(this._carrySubSequence)
         {
            this._carrySubSequence.removeEventListener(SequencerEvent.SEQUENCE_END,this.carryFinished);
            this._carrySubSequence = null;
         }
         var _loc2_:TiphonSprite = TiphonUtility.getEntityWithoutMount(DofusEntities.getEntity(this._fighterId) as TiphonSprite) as TiphonSprite;
         if((_loc2_) && (_loc2_ is TiphonSprite) && !this._isCreature)
         {
            (_loc2_ as TiphonSprite).addAnimationModifier(CarrierAnimationModifier.getInstance());
         }
         var _loc3_:IEntity = DofusEntities.getEntity(this._carriedId);
         if(_loc3_)
         {
            DisplayObject(_loc3_).x = 0;
            DisplayObject(_loc3_).y = 0;
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CARRY,[this._fighterId,this._carriedId],0,castingSpellId);
         FightSpellCastFrame.updateRangeAndTarget();
         executeCallbacks();
      }
      
      private function restart(param1:Event=null) : void {
         param1.currentTarget.removeEventListener(TiphonEvent.SUB_ENTITY_ADDED,this.restart);
         this.start();
      }
   }
}
