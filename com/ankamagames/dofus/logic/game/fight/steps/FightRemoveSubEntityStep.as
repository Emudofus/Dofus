package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;

    public class FightRemoveSubEntityStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _category:uint;
        private var _slot:uint;

        public function FightRemoveSubEntityStep(param1:int, param2:uint, param3:uint)
        {
            this._fighterId = param1;
            this._category = param2;
            this._slot = param3;
            return;
        }// end function

        public function get stepType() : String
        {
            return "removeSubEntity";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = DofusEntities.getEntity(this._fighterId);
            if (_loc_1 && _loc_1 is TiphonSprite)
            {
                (_loc_1 as TiphonSprite).look.removeSubEntity(this._category, this._slot);
            }
            else
            {
                _log.warn("Unable to remove a subentity from fighter " + this._fighterId + ", non-existing or not a sprite.");
            }
            executeCallbacks();
            return;
        }// end function

    }
}
