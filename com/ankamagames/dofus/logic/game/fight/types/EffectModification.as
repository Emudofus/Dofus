package com.ankamagames.dofus.logic.game.fight.types
{
    public class EffectModification 
    {

        private var _effectId:int;
        public var damagesBonus:int;
        public var shieldPoints:int;

        public function EffectModification(pEffectId:int)
        {
            this._effectId = pEffectId;
        }

        public function get effectId():int
        {
            return (this._effectId);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.types

