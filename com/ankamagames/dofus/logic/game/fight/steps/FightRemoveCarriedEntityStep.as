package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.tiphon.display.*;

    public class FightRemoveCarriedEntityStep extends FightRemoveSubEntityStep
    {
        private var _carriedId:int;

        public function FightRemoveCarriedEntityStep(param1:int, param2:int, param3:uint, param4:uint)
        {
            this._carriedId = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function get stepType() : String
        {
            return "removeCarriedEntity";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = DofusEntities.getEntity(this._carriedId) as TiphonSprite;
            var _loc_2:* = _loc_1.parentSprite;
            if (_loc_1 && _loc_2)
            {
                _loc_2.removeSubEntity(_loc_1);
            }
            super.start();
            return;
        }// end function

    }
}
