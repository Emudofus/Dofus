package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    final public class CurrentPlayedFighterManager extends Object
    {
        private var _currentFighterId:int = 0;
        private var _currentFighterIsRealPlayer:Boolean = true;
        private var _characteristicsInformationsList:Dictionary;
        private var _spellCastInFightManagerList:Dictionary;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(CurrentPlayedFighterManager));
        private static var _self:CurrentPlayedFighterManager;

        public function CurrentPlayedFighterManager()
        {
            this._characteristicsInformationsList = new Dictionary();
            this._spellCastInFightManagerList = new Dictionary();
            return;
        }// end function

        public function get currentFighterId() : int
        {
            return this._currentFighterId;
        }// end function

        public function set currentFighterId(param1:int) : void
        {
            if (param1 == this._currentFighterId)
            {
                return;
            }
            var _loc_2:* = this._currentFighterId;
            this._currentFighterId = param1;
            var _loc_3:* = PlayedCharacterManager.getInstance();
            this._currentFighterIsRealPlayer = this._currentFighterId == _loc_3.id;
            var _loc_4:* = DofusEntities.getEntity(_loc_2) as AnimatedCharacter;
            if (DofusEntities.getEntity(_loc_2) as AnimatedCharacter)
            {
                _loc_4.setCanSeeThrough(false);
            }
            var _loc_5:* = DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter;
            if (DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter)
            {
                _loc_5.setCanSeeThrough(true);
            }
            if (PlayedCharacterManager.getInstance().id != param1 || _loc_2)
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.SlaveStatsList, this.getCharacteristicsInformations());
            }
            if (this._currentFighterIsRealPlayer)
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork, 0);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork, 1519);
            }
            return;
        }// end function

        public function isRealPlayer() : Boolean
        {
            return this._currentFighterIsRealPlayer;
        }// end function

        public function resetPlayerSpellList() : void
        {
            var _loc_1:* = PlayedCharacterManager.getInstance();
            this.currentFighterId = _loc_1.id;
            var _loc_2:* = _loc_1.playerSpellList;
            if (_loc_1.spellsInventory != _loc_2)
            {
                _loc_1.spellsInventory = _loc_2;
                KernelEventsManager.getInstance().processCallback(HookList.SpellList, _loc_2);
            }
            if (_loc_1.playerShortcutList != InventoryManager.getInstance().shortcutBarSpells)
            {
                InventoryManager.getInstance().shortcutBarSpells = _loc_1.playerShortcutList;
                KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, 1);
            }
            return;
        }// end function

        public function setCharacteristicsInformations(param1:int, param2:CharacterCharacteristicsInformations) : void
        {
            this._characteristicsInformationsList[param1] = param2;
            return;
        }// end function

        public function getCharacteristicsInformations() : CharacterCharacteristicsInformations
        {
            var _loc_1:* = PlayedCharacterManager.getInstance();
            if (this._currentFighterIsRealPlayer || !_loc_1.isFighting)
            {
                return PlayedCharacterManager.getInstance().characteristics;
            }
            return this._characteristicsInformationsList[this._currentFighterId];
        }// end function

        public function getSpellById(param1:uint) : SpellWrapper
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_3:* = PlayedCharacterManager.getInstance();
            for each (_loc_4 in _loc_3.spellsInventory)
            {
                
                if (_loc_4.id == param1)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public function getSpellCastManager() : SpellCastInFightManager
        {
            var _loc_1:* = this._spellCastInFightManagerList[this._currentFighterId];
            if (!_loc_1)
            {
                _loc_1 = new SpellCastInFightManager(this._currentFighterId);
                this._spellCastInFightManagerList[this._currentFighterId] = _loc_1;
            }
            return _loc_1;
        }// end function

        public function getSpellCastManagerById(param1:int) : SpellCastInFightManager
        {
            var _loc_2:* = this._spellCastInFightManagerList[param1];
            if (!_loc_2)
            {
                _loc_2 = new SpellCastInFightManager(param1);
                this._spellCastInFightManagerList[this._currentFighterId] = _loc_2;
            }
            return _loc_2;
        }// end function

        public function canCastThisSpell(param1:uint, param2:uint, param3:int = 2147483647) : Boolean
        {
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_11:* = 0;
            var _loc_13:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_4:* = Spell.getSpellById(param1);
            var _loc_5:* = Spell.getSpellById(param1).getSpellLevel(param2);
            if (Spell.getSpellById(param1).getSpellLevel(param2) == null)
            {
                return false;
            }
            var _loc_7:* = PlayedCharacterManager.getInstance();
            for each (_loc_8 in _loc_7.spellsInventory)
            {
                
                if (_loc_8.id == param1)
                {
                    _loc_6 = _loc_8;
                    continue;
                }
            }
            if (!_loc_6)
            {
                return false;
            }
            var _loc_9:* = this.getCharacteristicsInformations();
            if (!this.getCharacteristicsInformations())
            {
                return false;
            }
            var _loc_10:* = _loc_9.actionPointsCurrent;
            if (param1 == 0 && _loc_7.currentWeapon != null)
            {
                _loc_19 = Item.getItemById(_loc_7.currentWeapon.objectGID) as Weapon;
                if (!_loc_19)
                {
                    return false;
                }
                _loc_11 = _loc_19.apCost;
            }
            else
            {
                _loc_11 = _loc_6.apCost;
            }
            var _loc_12:* = new SpellModificator();
            for each (_loc_13 in _loc_9.spellModifications)
            {
                
                if (_loc_13.spellId == param1)
                {
                    switch(_loc_13.modificationType)
                    {
                        case CharacterSpellModificationTypeEnum.AP_COST:
                        {
                            _loc_12.apCost = _loc_13.value;
                            break;
                        }
                        case CharacterSpellModificationTypeEnum.CAST_INTERVAL:
                        {
                            _loc_12.castInterval = _loc_13.value;
                            break;
                        }
                        case CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET:
                        {
                            _loc_12.castIntervalSet = _loc_13.value;
                            break;
                        }
                        case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET:
                        {
                            _loc_12.maxCastPerTarget = _loc_13.value;
                            break;
                        }
                        case CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN:
                        {
                            _loc_12.maxCastPerTurn = _loc_13.value;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            if (_loc_11 > _loc_10)
            {
                return false;
            }
            var _loc_14:* = FightersStateManager.getInstance().getStates(this._currentFighterId);
            if (!FightersStateManager.getInstance().getStates(this._currentFighterId))
            {
                _loc_14 = new Array();
            }
            for each (_loc_15 in _loc_14)
            {
                
                _loc_20 = SpellState.getSpellStateById(_loc_15);
                if (_loc_20.preventsFight && param1 == 0)
                {
                    return false;
                }
                if (_loc_20.id == 101 && param1 == 0)
                {
                    _loc_21 = Item.getItemById(_loc_7.currentWeapon.objectGID) as Weapon;
                    if (_loc_21.typeId != 2)
                    {
                        return false;
                    }
                }
                if (_loc_5.statesForbidden && _loc_5.statesForbidden.indexOf(_loc_15) != -1)
                {
                    return false;
                }
                if (_loc_20.preventsSpellCast)
                {
                    if (_loc_5.statesRequired)
                    {
                        if (_loc_5.statesRequired.indexOf(_loc_15) == -1)
                        {
                            return false;
                        }
                        continue;
                    }
                    return false;
                }
            }
            for each (_loc_16 in _loc_5.statesRequired)
            {
                
                if (_loc_14.indexOf(_loc_16) == -1)
                {
                    return false;
                }
            }
            if (_loc_5.canSummon && !_loc_7.canSummon())
            {
                return false;
            }
            if (_loc_5.canBomb && !_loc_7.canBomb())
            {
                return false;
            }
            if (!_loc_7.isFighting)
            {
                return true;
            }
            var _loc_17:* = this.getSpellCastManager();
            var _loc_18:* = this.getSpellCastManager().getSpellManagerBySpellId(param1);
            if (this.getSpellCastManager().getSpellManagerBySpellId(param1) == null)
            {
                return true;
            }
            if (_loc_6.maxCastPerTurn <= _loc_18.numberCastThisTurn && _loc_6.maxCastPerTurn > 0)
            {
                return false;
            }
            if (_loc_18.cooldown > 0 || _loc_6.actualCooldown > 0)
            {
                return false;
            }
            _loc_22 = _loc_18.getCastOnEntity(param3);
            if (_loc_5.maxCastPerTarget + _loc_12.getTotalBonus(_loc_12.maxCastPerTarget) <= _loc_22 && _loc_5.maxCastPerTarget > 0)
            {
                return false;
            }
            return true;
        }// end function

        public function endFight() : void
        {
            this._currentFighterId = 0;
            this._characteristicsInformationsList = new Dictionary();
            this._spellCastInFightManagerList = new Dictionary();
            return;
        }// end function

        public function getSpellModifications(param1:int, param2:int) : CharacterSpellModification
        {
            var _loc_4:* = null;
            var _loc_3:* = this.getCharacteristicsInformations();
            if (_loc_3)
            {
                for each (_loc_4 in _loc_3.spellModifications)
                {
                    
                    if (_loc_4.spellId == param1 && _loc_4.modificationType == param2)
                    {
                        return _loc_4;
                    }
                }
            }
            return null;
        }// end function

        public static function getInstance() : CurrentPlayedFighterManager
        {
            if (_self == null)
            {
                _self = new CurrentPlayedFighterManager;
                _self.currentFighterId = PlayedCharacterManager.getInstance().id;
            }
            return _self;
        }// end function

    }
}
