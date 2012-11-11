package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import flash.display.*;
    import flash.events.*;

    public class FightVanishStep extends AbstractSequencable implements IFightStep
    {
        private var _entityId:int;
        private var _sourceId:int;
        private var _vanishSubSequence:ISequencer;

        public function FightVanishStep(param1:int, param2:int)
        {
            this._entityId = param1;
            this._sourceId = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "vanish";
        }// end function

        public function get entityId() : int
        {
            return this._entityId;
        }// end function

        override public function start() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._entityId);
            if (!_loc_1)
            {
                _log.warn("Unable to play vanish of an unexisting fighter " + this._entityId + ".");
                this.vanishFinished();
                return;
            }
            BuffManager.getInstance().dispell(_loc_1.id, false, false, true);
            _loc_2 = BuffManager.getInstance().removeLinkedBuff(_loc_1.id, false, true);
            BuffManager.getInstance().reaffectBuffs(_loc_1.id);
            this._vanishSubSequence = new SerialSequencer(FightBattleFrame.FIGHT_SEQUENCER_NAME);
            _loc_3 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._sourceId).disposition.cellId;
            if (_loc_1 is TiphonSprite && _loc_1.position.cellId != _loc_3)
            {
                _loc_4 = _loc_1 as TiphonSprite;
                _loc_5 = _loc_4.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite;
                if (_loc_5)
                {
                    _loc_4 = _loc_5;
                }
                this._vanishSubSequence.addStep(new PlayAnimationStep(_loc_4, AnimationEnum.ANIM_VANISH));
                this._vanishSubSequence.addStep(new CallbackStep(new Callback(this.onAnimEnd, _loc_1)));
            }
            this._vanishSubSequence.addStep(new CallbackStep(new Callback(this.manualRollOut, this._entityId)));
            this._vanishSubSequence.addStep(new FightDestroyEntityStep(_loc_1));
            this._vanishSubSequence.addEventListener(SequencerEvent.SEQUENCE_END, this.vanishFinished);
            this._vanishSubSequence.start();
            return;
        }// end function

        override public function clear() : void
        {
            if (this._vanishSubSequence)
            {
                this._vanishSubSequence.clear();
            }
            super.clear();
            return;
        }// end function

        private function manualRollOut(param1:int) : void
        {
            var _loc_2:* = null;
            if (FightContextFrame.fighterEntityTooltipId == param1)
            {
                TooltipManager.hide();
                TooltipManager.hide("fighter");
                _loc_2 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                if (_loc_2)
                {
                    _loc_2.outEntity(param1);
                }
            }
            return;
        }// end function

        private function onAnimEnd(param1:TiphonSprite) : void
        {
            var _loc_2:* = param1.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite;
            if (_loc_2)
            {
                param1 = _loc_2;
            }
            var _loc_3:* = param1.getSubEntitySlot(FightCarryCharacterStep.CARRIED_SUBENTITY_CATEGORY, FightCarryCharacterStep.CARRIED_SUBENTITY_INDEX);
            if (_loc_3)
            {
                param1.removeSubEntity(_loc_3);
            }
            return;
        }// end function

        private function vanishFinished(event:Event = null) : void
        {
            if (this._vanishSubSequence)
            {
                this._vanishSubSequence.removeEventListener(SequencerEvent.SEQUENCE_END, this.vanishFinished);
                this._vanishSubSequence = null;
            }
            executeCallbacks();
            return;
        }// end function

    }
}
