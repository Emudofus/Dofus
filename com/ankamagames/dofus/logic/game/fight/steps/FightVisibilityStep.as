package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.jerakine.sequencer.*;
    import flash.display.*;

    public class FightVisibilityStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _visibility:Boolean;

        public function FightVisibilityStep(param1:int, param2:Boolean)
        {
            this._fighterId = param1;
            this._visibility = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "visibility";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = DofusEntities.getEntity(this._fighterId) as Sprite;
            _loc_1.visible = this._visibility;
            executeCallbacks();
            return;
        }// end function

    }
}
