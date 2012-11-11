package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
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

    public class FightCarryCharacterStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _carriedId:int;
        private var _cellId:int;
        private var _carrySubSequence:ISequencer;
        private var _noAnimation:Boolean;
        private var _isCreature:Boolean;
        static const CARRIED_SUBENTITY_CATEGORY:uint = 3;
        static const CARRIED_SUBENTITY_INDEX:uint = 0;

        public function FightCarryCharacterStep(param1:int, param2:int, param3:int = -1, param4:Boolean = false)
        {
            this._fighterId = param1;
            this._carriedId = param2;
            this._cellId = param3;
            this._noAnimation = param4;
            this._isCreature = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).isInCreaturesFightMode();
            return;
        }// end function

        public function get stepType() : String
        {
            return "carryCharacter";
        }// end function

        override public function start() : void
        {
            var _loc_4:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._fighterId);
            var _loc_2:* = _loc_1.position;
            var _loc_3:* = _loc_1 as TiphonSprite;
            _loc_4 = DofusEntities.getEntity(this._carriedId);
            if ((_loc_1 as AnimatedCharacter).isMounted() && !this._isCreature)
            {
                _loc_7 = _loc_3.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite;
                if (_loc_7 == null)
                {
                    if (!_loc_3.hasEventListener(TiphonEvent.SUB_ENTITY_ADDED))
                    {
                        _loc_3.addEventListener(TiphonEvent.SUB_ENTITY_ADDED, this.restart);
                    }
                    return;
                }
                _loc_3 = _loc_7;
            }
            if (!_loc_3 || !_loc_4)
            {
                _log.warn("Unable to make " + this._fighterId + " carry " + this._carriedId + ", one of them is not in the stage.");
                this.carryFinished();
                return;
            }
            if (_loc_3 is TiphonSprite && _loc_4 is TiphonSprite && TiphonSprite(_loc_4).parentSprite == _loc_3)
            {
                executeCallbacks();
                return;
            }
            var _loc_5:* = !FightEntitiesHolder.getInstance().getEntity(_loc_4.id);
            this._carrySubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
            if (_loc_3 is TiphonSprite)
            {
                if (this._cellId == -1)
                {
                    _loc_8 = _loc_4.position;
                }
                else
                {
                    _loc_8 = MapPoint.fromCellId(this._cellId);
                }
                if (_loc_8)
                {
                    this._carrySubSequence.addStep(new SetDirectionStep(_loc_3.rootEntity, _loc_2.advancedOrientationTo(_loc_8)));
                }
            }
            var _loc_6:* = (_loc_4 as TiphonSprite).look;
            if (!_loc_5)
            {
                _loc_6.resetSkins();
                _loc_6.setBone(761);
            }
            DisplayObject(_loc_4).x = 0;
            DisplayObject(_loc_4).y = 0;
            this._carrySubSequence.addStep(new FightAddSubEntityStep(this._fighterId, this._carriedId, CARRIED_SUBENTITY_CATEGORY, CARRIED_SUBENTITY_INDEX, new CarrierSubEntityBehaviour()));
            if (_loc_3 is TiphonSprite)
            {
                if (!this._noAnimation && !this._isCreature)
                {
                    this._carrySubSequence.addStep(new PlayAnimationStep(_loc_3 as TiphonSprite, AnimationEnum.ANIM_PICKUP, false));
                }
                this._carrySubSequence.addStep(new SetAnimationStep(_loc_3 as TiphonSprite, this._isCreature ? (AnimationEnum.ANIM_STATIQUE) : (AnimationEnum.ANIM_STATIQUE_CARRYING)));
            }
            this._carrySubSequence.addEventListener(SequencerEvent.SEQUENCE_END, this.carryFinished);
            this._carrySubSequence.start();
            return;
        }// end function

        private function carryFinished(event:Event = null) : void
        {
            if (this._carrySubSequence)
            {
                this._carrySubSequence.removeEventListener(SequencerEvent.SEQUENCE_END, this.carryFinished);
                this._carrySubSequence = null;
            }
            var _loc_2:* = TiphonUtility.getEntityWithoutMount(DofusEntities.getEntity(this._fighterId) as TiphonSprite) as TiphonSprite;
            if (_loc_2 && _loc_2 is TiphonSprite && !this._isCreature)
            {
                (_loc_2 as TiphonSprite).addAnimationModifier(CarrierAnimationModifier.getInstance());
            }
            var _loc_3:* = DofusEntities.getEntity(this._carriedId);
            if (_loc_3)
            {
                DisplayObject(_loc_3).x = 0;
                DisplayObject(_loc_3).y = 0;
            }
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CARRY, [this._fighterId, this._carriedId], 0, castingSpellId);
            FightSpellCastFrame.updateRangeAndTarget();
            executeCallbacks();
            return;
        }// end function

        private function restart(event:Event = null) : void
        {
            event.currentTarget.removeEventListener(TiphonEvent.SUB_ENTITY_ADDED, this.restart);
            this.start();
            return;
        }// end function

    }
}
