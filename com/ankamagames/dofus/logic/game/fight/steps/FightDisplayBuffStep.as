package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.miscs.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightDisplayBuffStep extends AbstractSequencable implements IFightStep, ISequencableListener
    {
        private var _buff:BasicBuff;
        private var _virtualStep:IFightStep;

        public function FightDisplayBuffStep(param1:BasicBuff)
        {
            this._buff = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "displayBuff";
        }// end function

        override public function start() : void
        {
            var _loc_2:String = null;
            var _loc_1:Boolean = true;
            if (this._buff.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
            {
                _loc_1 = !BuffManager.getInstance().updateBuff(this._buff);
            }
            else if (_loc_1)
            {
                if (this._buff is StatBuff)
                {
                    _loc_2 = (this._buff as StatBuff).statName;
                    switch(_loc_2)
                    {
                        case "movementPoints":
                        {
                            this._virtualStep = new FightMovementPointsVariationStep(this._buff.targetId, (this._buff as StatBuff).delta, false, false, false);
                            break;
                        }
                        case "actionPoints":
                        {
                            this._virtualStep = new FightActionPointsVariationStep(this._buff.targetId, (this._buff as StatBuff).delta, false, false, false);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                BuffManager.getInstance().addBuff(this._buff);
            }
            if (!this._virtualStep)
            {
                executeCallbacks();
            }
            else
            {
                this._virtualStep.addListener(this);
                this._virtualStep.start();
            }
            return;
        }// end function

        public function stepFinished() : void
        {
            this._virtualStep.removeListener(this);
            executeCallbacks();
            return;
        }// end function

    }
}
