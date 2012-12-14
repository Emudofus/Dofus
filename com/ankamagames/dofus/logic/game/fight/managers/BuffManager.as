package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class BuffManager extends Object
    {
        private var _buffs:Array;
        private var _finishingBuffs:Dictionary;
        public static const INCREMENT_MODE_SOURCE:int = 1;
        public static const INCREMENT_MODE_TARGET:int = 2;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(BuffManager));
        private static var _self:BuffManager;

        public function BuffManager()
        {
            this._buffs = new Array();
            this._finishingBuffs = new Dictionary();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        public function decrementDuration(param1:int) : void
        {
            this.incrementDuration(param1, -1);
            return;
        }// end function

        public function synchronize() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._buffs)
            {
                
                for each (_loc_2 in _loc_1)
                {
                    
                    _loc_2.undisable();
                }
            }
            return;
        }// end function

        public function incrementDuration(param1:int, param2:int, param3:Boolean = false, param4:int = 1) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_5:* = new Array();
            var _loc_6:* = false;
            for each (_loc_7 in this._buffs)
            {
                
                for each (_loc_8 in _loc_7)
                {
                    
                    if (param4 == INCREMENT_MODE_SOURCE && _loc_8.aliveSource == param1 || param4 == INCREMENT_MODE_TARGET && _loc_8.targetId == param1)
                    {
                        _loc_9 = _loc_8.incrementDuration(param2, param3);
                        if (_loc_8.active)
                        {
                            if (!_loc_5.hasOwnProperty(String(_loc_8.targetId)))
                            {
                                _loc_5[_loc_8.targetId] = new Array();
                            }
                            _loc_5[_loc_8.targetId].push(_loc_8);
                            if (_loc_9)
                            {
                                KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, _loc_8.id, _loc_8.targetId);
                            }
                        }
                        else
                        {
                            BasicBuff(_loc_8).onRemoved();
                            KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, _loc_8, _loc_8.targetId, "CoolDown");
                            _loc_6 = true;
                        }
                        continue;
                    }
                    if (!_loc_5.hasOwnProperty(String(_loc_8.targetId)))
                    {
                        _loc_5[_loc_8.targetId] = new Array();
                    }
                    _loc_5[_loc_8.targetId].push(_loc_8);
                }
            }
            if (_loc_6)
            {
                KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            }
            this._buffs = _loc_5;
            return;
        }// end function

        public function markFinishingBuffs(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            if (this._buffs.hasOwnProperty(String(param1)))
            {
                _loc_3 = false;
                for each (_loc_4 in this._buffs[param1])
                {
                    
                    _loc_5 = false;
                    if (_loc_4.duration == 1)
                    {
                        _loc_6 = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                        if (_loc_6 == null)
                        {
                            return;
                        }
                        _loc_7 = 0;
                        for each (_loc_8 in _loc_6.fightersList)
                        {
                            
                            if (_loc_8 == _loc_6.currentPlayerId)
                            {
                                _loc_7 = 1;
                            }
                            if (_loc_7 == 1)
                            {
                                if (_loc_8 == _loc_4.aliveSource && (_loc_8 != _loc_6.currentPlayerId || !param2))
                                {
                                    _loc_7 = 2;
                                    _loc_5 = true;
                                    continue;
                                }
                                if (_loc_8 == param1 && _loc_8 != _loc_6.currentPlayerId)
                                {
                                    _loc_7 = 2;
                                    _loc_5 = false;
                                }
                            }
                        }
                        if (_loc_7 == 1)
                        {
                            for each (_loc_8 in _loc_6.fightersList)
                            {
                                
                                if (_loc_8 == _loc_4.aliveSource)
                                {
                                    _loc_7 = 2;
                                    _loc_5 = true;
                                    continue;
                                }
                                if (_loc_8 == param1)
                                {
                                    _loc_7 = 2;
                                    _loc_5 = false;
                                }
                            }
                        }
                        if (_loc_5 && !param2)
                        {
                            _loc_4.finishing = true;
                            if (_loc_4 is StatBuff && param1 != PlayedCharacterManager.getInstance().id)
                            {
                                _loc_9 = _loc_4 as StatBuff;
                                if (_loc_9.statName)
                                {
                                    param1 = _loc_9.targetId;
                                    if (!this._finishingBuffs[param1])
                                    {
                                        this._finishingBuffs[param1] = new Array();
                                    }
                                    this._finishingBuffs[param1].push(_loc_4);
                                }
                            }
                            BasicBuff(_loc_4).onDisabled();
                            _loc_3 = true;
                        }
                    }
                }
                if (_loc_3)
                {
                    KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
                }
            }
            return;
        }// end function

        public function addBuff(param1:BasicBuff) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this._buffs[param1.targetId])
            {
                this._buffs[param1.targetId] = new Array();
            }
            for each (_loc_3 in this._buffs[param1.targetId])
            {
                
                if (param1.equals(_loc_3))
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            if (!_loc_2)
            {
                this._buffs[param1.targetId].push(param1);
            }
            else
            {
                _loc_2.add(param1);
            }
            param1.onApplyed();
            if (!_loc_2)
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.BuffAdd, param1.id, param1.targetId);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, _loc_2.id, _loc_2.targetId);
            }
            return;
        }// end function

        public function updateBuff(param1:BasicBuff) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.targetId;
            if (!this._buffs[_loc_2])
            {
                return false;
            }
            var _loc_4:* = this.getBuffIndex(_loc_2, param1.id);
            if (this.getBuffIndex(_loc_2, param1.id) == -1)
            {
                return false;
            }
            (this._buffs[_loc_2][_loc_4] as BasicBuff).onRemoved();
            (this._buffs[_loc_2][_loc_4] as BasicBuff).updateParam(param1.param1, param1.param2, param1.param3, param1.id);
            _loc_3 = this._buffs[_loc_2][_loc_4];
            if (!_loc_3)
            {
                return false;
            }
            _loc_3.onApplyed();
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate, _loc_3.id, _loc_2);
            return true;
        }// end function

        public function dispell(param1:int, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
        {
            var _loc_7:* = null;
            var _loc_5:* = new Array();
            var _loc_6:* = new Array();
            for each (_loc_7 in this._buffs[param1])
            {
                
                if (_loc_7.canBeDispell(param2, int.MIN_VALUE, param4))
                {
                    KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, _loc_7, param1, "Dispell");
                    _loc_7.onRemoved();
                    _loc_5.push(_loc_7);
                    continue;
                }
                _loc_6.push(_loc_7);
            }
            this._buffs[param1] = _loc_6;
            return;
        }// end function

        public function dispellSpell(param1:int, param2:uint, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_6:* = new Array();
            var _loc_7:* = new Array();
            for each (_loc_8 in this._buffs[param1])
            {
                
                if (param2 == _loc_8.castingSpell.spell.id && _loc_8.canBeDispell(param3, int.MIN_VALUE, param5))
                {
                    _loc_8.onRemoved();
                    _loc_6.push(_loc_8);
                    continue;
                }
                _loc_7.push(_loc_8);
            }
            this._buffs[param1] = _loc_7;
            for each (_loc_9 in _loc_6)
            {
                
                KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove, _loc_9, param1, "Dispell");
            }
            return;
        }// end function

        public function dispellUniqueBuff(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true) : void
        {
            var _loc_6:* = this.getBuffIndex(param1, param2);
            if (this.getBuffIndex(param1, param2) == -1)
            {
                return;
            }
            var _loc_7:* = this._buffs[param1][_loc_6];
            if (this._buffs[param1][_loc_6].canBeDispell(param3, param5 ? (param2) : (int.MIN_VALUE), param4))
            {
                switch(_loc_7.actionId)
                {
                    case 293:
                    {
                        break;
                    }
                    case 788:
                    {
                        break;
                    }
                    case 950:
                    case 951:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function removeLinkedBuff(param1:int, param2:Boolean = false, param3:Boolean = false) : Array
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_4:* = [];
            var _loc_5:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_6:* = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(param1) as GameFightFighterInformations;
            for each (_loc_7 in this._buffs)
            {
                
                _loc_8 = new Array();
                for each (_loc_9 in _loc_7)
                {
                    
                    _loc_8.push(_loc_9);
                }
                for each (_loc_9 in _loc_8)
                {
                    
                    if (_loc_9.source == param1)
                    {
                        this.dispellUniqueBuff(_loc_9.targetId, _loc_9.id, param2, param3, false);
                        if (_loc_4.indexOf(_loc_9.targetId) == -1)
                        {
                            _loc_4.push(_loc_9.targetId);
                        }
                        if (param3 && _loc_6.stats.summoned)
                        {
                            _loc_9.aliveSource = _loc_6.stats.summoner;
                        }
                    }
                }
            }
            return _loc_4;
        }// end function

        public function reaffectBuffs(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = this.fightEntitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
            if (_loc_2.stats.summoned)
            {
                _loc_3 = this.getNextFighter(param1);
                if (_loc_3 == -1)
                {
                    return;
                }
                for each (_loc_4 in this._buffs)
                {
                    
                    for each (_loc_5 in _loc_4)
                    {
                        
                        if (_loc_5.aliveSource == param1)
                        {
                            _loc_5.aliveSource = _loc_3;
                        }
                    }
                }
            }
            return;
        }// end function

        private function getNextFighter(param1:int) : int
        {
            var _loc_4:* = 0;
            var _loc_2:* = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if (_loc_2 == null)
            {
                return -1;
            }
            var _loc_3:* = false;
            for each (_loc_4 in _loc_2.fightersList)
            {
                
                if (_loc_3)
                {
                    return _loc_4;
                }
                if (_loc_4 == param1)
                {
                    _loc_3 = true;
                }
            }
            if (_loc_3)
            {
                return _loc_2.fightersList[0];
            }
            return -1;
        }// end function

        public function getFighterInfo(param1:int) : GameFightFighterInformations
        {
            return this.fightEntitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
        }// end function

        public function getAllBuff(param1:int) : Array
        {
            return this._buffs[param1];
        }// end function

        public function getBuff(param1:uint, param2:int) : BasicBuff
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._buffs[param2])
            {
                
                if (param1 == _loc_3.id)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function getFinishingBuffs(param1:int) : Array
        {
            var _loc_2:* = this._finishingBuffs[param1];
            delete this._finishingBuffs[param1];
            return _loc_2;
        }// end function

        private function get fightEntitiesFrame() : FightEntitiesFrame
        {
            return Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
        }// end function

        private function getBuffIndex(param1:int, param2:int) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for (_loc_3 in this._buffs[param1])
            {
                
                if (param2 == this._buffs[param1][_loc_3].id)
                {
                    return int(_loc_3);
                }
                for each (_loc_4 in (this._buffs[param1][_loc_3] as BasicBuff).stack)
                {
                    
                    if (param2 == _loc_4.id)
                    {
                        return int(_loc_3);
                    }
                }
            }
            return -1;
        }// end function

        public static function getInstance() : BuffManager
        {
            if (!_self)
            {
                _self = new BuffManager;
            }
            return _self;
        }// end function

        public static function makeBuffFromEffect(param1:AbstractFightDispellableEffect, param2:CastingSpell, param3:uint) : BasicBuff
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(true)
            {
                case param1 is FightTemporarySpellBoostEffect:
                {
                    _loc_4 = new SpellBuff(param1 as FightTemporarySpellBoostEffect, param2, param3);
                    break;
                }
                case param1 is FightTriggeredEffect:
                {
                    _loc_4 = new TriggeredBuff(param1 as FightTriggeredEffect, param2, param3);
                    break;
                }
                case param1 is FightTemporaryBoostWeaponDamagesEffect:
                {
                    _loc_5 = param1 as FightTemporaryBoostWeaponDamagesEffect;
                    _loc_4 = new BasicBuff(param1, param2, param3, _loc_5.weaponTypeId, _loc_5.delta, _loc_5.weaponTypeId);
                    break;
                }
                case param1 is FightTemporaryBoostStateEffect:
                {
                    _loc_4 = new StateBuff(param1 as FightTemporaryBoostStateEffect, param2, param3);
                    break;
                }
                case param1 is FightTemporarySpellImmunityEffect:
                {
                    _loc_6 = param1 as FightTemporarySpellImmunityEffect;
                    _loc_4 = new BasicBuff(param1, param2, param3, _loc_6.immuneSpellId, null, null);
                    break;
                }
                case param1 is FightTemporaryBoostEffect:
                {
                    _loc_4 = new StatBuff(param1 as FightTemporaryBoostEffect, param2, param3);
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_4.id = param1.uid;
            return _loc_4;
        }// end function

    }
}
