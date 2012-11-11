package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SpellCastInFightManager extends Object
    {
        private var _spells:Dictionary;
        private var skipFirstTurn:Boolean = true;
        public var currentTurn:int = 0;
        public var entityId:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellCastInFightManager));

        public function SpellCastInFightManager(param1:int)
        {
            this._spells = new Dictionary();
            this.entityId = param1;
            return;
        }// end function

        public function nextTurn() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = this;
            var _loc_3:* = this.currentTurn + 1;
            _loc_2.currentTurn = _loc_3;
            for each (_loc_1 in this._spells)
            {
                
                _loc_1.newTurn();
            }
            return;
        }// end function

        public function resetInitialCooldown() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            var _loc_2:* = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
            for each (_loc_3 in _loc_2.fullSpellList)
            {
                
                if (_loc_3.spellLevelInfos.initialCooldown != 0)
                {
                    if (this._spells[_loc_3.spellId] == null)
                    {
                        this._spells[_loc_3.spellId] = new SpellManager(this, _loc_3.spellId, _loc_3.spellLevel);
                    }
                    _loc_1 = this._spells[_loc_3.spellId];
                    _loc_1.resetInitialCooldown(this.currentTurn);
                }
            }
            return;
        }// end function

        public function castSpell(param1:uint, param2:uint, param3:Array, param4:Boolean = true) : void
        {
            if (this._spells[param1] == null)
            {
                this._spells[param1] = new SpellManager(this, param1, param2);
            }
            (this._spells[param1] as SpellManager).cast(this.currentTurn, param3, param4);
            return;
        }// end function

        public function getSpellManagerBySpellId(param1:uint) : SpellManager
        {
            return this._spells[param1] as SpellManager;
        }// end function

    }
}
