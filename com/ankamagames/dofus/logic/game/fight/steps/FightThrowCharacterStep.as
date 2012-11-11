package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.types.sequences.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.sequence.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.events.*;

    public class FightThrowCharacterStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _carriedId:int;
        private var _cellId:int;
        private var _throwSubSequence:ISequencer;
        private var _isCreature:Boolean;
        private static const THROWING_PROJECTILE_FX:uint = 21209;

        public function FightThrowCharacterStep(param1:int, param2:int, param3:int)
        {
            this._fighterId = param1;
            this._carriedId = param2;
            this._cellId = param3;
            this._isCreature = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).isInCreaturesFightMode();
            return;
        }// end function

        public function get stepType() : String
        {
            return "throwCharacter";
        }// end function

        override public function start() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._fighterId) as DisplayObject;
            var _loc_2:* = _loc_1 as IEntity;
            _loc_1 = TiphonUtility.getEntityWithoutMount(_loc_1 as TiphonSprite);
            var _loc_3:* = DofusEntities.getEntity(this._carriedId);
            if (!_loc_3)
            {
                _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
                this.throwFinished();
                return;
            }
            if (!_loc_1)
            {
                _log.error("Attention, l\'entité [" + this._fighterId + "] ne porte pas [" + this._carriedId + "]");
                (_loc_3 as IDisplayable).display(PlacementStrataEnums.STRATA_PLAYER);
                if (_loc_3 is TiphonSprite)
                {
                    (_loc_3 as TiphonSprite).setAnimation(AnimationEnum.ANIM_STATIQUE);
                }
                this.throwFinished();
                return;
            }
            if (this._cellId != -1)
            {
                _loc_8 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._carriedId) as GameFightFighterInformations;
                _loc_8.disposition.cellId = this._cellId;
            }
            if (this._carriedId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                _loc_9 = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
                if (_loc_9)
                {
                    _loc_9.freePlayer();
                }
            }
            var _loc_4:* = false;
            if (TiphonSprite(_loc_3).look.getBone() == 761)
            {
                _loc_4 = true;
            }
            _log.debug(this._fighterId + " is throwing " + this._carriedId + " (invisibility : " + _loc_4 + ")");
            if (!_loc_4)
            {
                FightEntitiesHolder.getInstance().unholdEntity(this._carriedId);
            }
            if (_loc_1 && _loc_1 is TiphonSprite)
            {
                (_loc_1 as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
            }
            this._throwSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
            if (this._cellId == -1 || _loc_4)
            {
                if (_loc_1 is TiphonSprite)
                {
                    this._throwSubSequence.addStep(new SetAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_STATIQUE));
                }
                this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId, this._carriedId, FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY, FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
                this.startSubSequence();
                if (this._cellId == -1)
                {
                    return;
                }
            }
            var _loc_5:* = MapPoint.fromCellId(this._cellId);
            _loc_3.position = _loc_5;
            if (_loc_4)
            {
                return;
            }
            var _loc_6:* = _loc_2.position.distanceToCell(_loc_5);
            var _loc_7:* = _loc_2.position.advancedOrientationTo(_loc_5);
            if (_loc_1 is TiphonSprite)
            {
                this._throwSubSequence.addStep(new SetDirectionStep((_loc_1 as TiphonSprite).rootEntity, _loc_7));
            }
            if (_loc_6 == 1)
            {
                _log.debug("Dropping nearby.");
                if (_loc_1 is TiphonSprite)
                {
                    if (!this._isCreature)
                    {
                        this._throwSubSequence.addStep(new PlayAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_DROP, false));
                    }
                    else
                    {
                        this._throwSubSequence.addStep(new SetAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_STATIQUE));
                    }
                }
            }
            else
            {
                _log.debug("Throwing away.");
                if (_loc_1 is TiphonSprite)
                {
                    if (!this._isCreature)
                    {
                        this._throwSubSequence.addStep(new PlayAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_THROW, false, true, TiphonEvent.ANIMATION_SHOT));
                    }
                    else
                    {
                        (_loc_3 as TiphonSprite).visible = false;
                    }
                    this._throwSubSequence.addStep(new SetAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_STATIQUE));
                }
                _loc_10 = new Projectile(EntitiesManager.getInstance().getFreeEntityId(), TiphonEntityLook.fromString("{" + THROWING_PROJECTILE_FX + "}"));
                _loc_10.position = _loc_2.position.getNearestCellInDirection(_loc_7);
                this._throwSubSequence.addStep(new AddWorldEntityStep(_loc_10));
                this._throwSubSequence.addStep(new ParableGfxMovementStep(_loc_10, _loc_5, 200, 0.3, -70, true, 1));
                this._throwSubSequence.addStep(new FightDestroyEntityStep(_loc_10));
            }
            this._throwSubSequence.addStep(new FightRemoveCarriedEntityStep(this._fighterId, this._carriedId, FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY, FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX));
            this._throwSubSequence.addStep(new SetDirectionStep(_loc_3 as TiphonSprite, (_loc_1 as TiphonSprite).rootEntity.getDirection()));
            this._throwSubSequence.addStep(new AddWorldEntityStep(_loc_3));
            this._throwSubSequence.addStep(new SetAnimationStep(_loc_3 as TiphonSprite, AnimationEnum.ANIM_STATIQUE));
            if (_loc_1 is TiphonSprite)
            {
                this._throwSubSequence.addStep(new SetAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_STATIQUE));
            }
            this.startSubSequence();
            return;
        }// end function

        private function startSubSequence() : void
        {
            this._throwSubSequence.addEventListener(SequencerEvent.SEQUENCE_END, this.throwFinished);
            this._throwSubSequence.start();
            return;
        }// end function

        private function throwFinished(event:Event = null) : void
        {
            var _loc_4:* = null;
            if (this._throwSubSequence)
            {
                this._throwSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END, this.throwFinished);
                this._throwSubSequence = null;
            }
            var _loc_2:* = DofusEntities.getEntity(this._fighterId) as DisplayObject;
            if (_loc_2 is TiphonSprite)
            {
                _loc_4 = (_loc_2 as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
                if (_loc_4)
                {
                    _loc_2 = _loc_4;
                }
            }
            var _loc_3:* = DofusEntities.getEntity(this._carriedId);
            if (_loc_2 && _loc_2 is TiphonSprite)
            {
                (_loc_2 as TiphonSprite).removeAnimationModifierByClass(CarrierAnimationModifier);
                (_loc_2 as TiphonSprite).removeSubEntity(_loc_3 as DisplayObject);
            }
            (_loc_3 as TiphonSprite).visible = true;
            if (_loc_3 is IMovable)
            {
                IMovable(_loc_3).movementBehavior.synchroniseSubEntitiesPosition(IMovable(_loc_3));
            }
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_THROW, [this._fighterId, this._carriedId, this._cellId], 0, castingSpellId);
            FightSpellCastFrame.updateRangeAndTarget();
            executeCallbacks();
            return;
        }// end function

        override public function toString() : String
        {
            return "[FightThrowCharacterStep(carrier=" + this._fighterId + ", carried=" + this._carriedId + ", cell=" + this._cellId + ")]";
        }// end function

    }
}
