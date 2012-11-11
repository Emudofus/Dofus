package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;

    public class FightChangeLookStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _newLook:TiphonEntityLook;

        public function FightChangeLookStep(param1:int, param2:TiphonEntityLook)
        {
            this._fighterId = param1;
            this._newLook = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "changeLook";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = new GameContextRefreshEntityLookMessage();
            _loc_1.initGameContextRefreshEntityLookMessage(this._fighterId, EntityLookAdapter.toNetwork(this._newLook));
            Kernel.getWorker().getFrame(FightEntitiesFrame).process(_loc_1);
            this._newLook = TiphonUtility.getLookWithoutMount(this._newLook);
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CHANGE_LOOK, [this._fighterId, this._newLook], this._fighterId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
