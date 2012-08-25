package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.inventory.spells.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class SpellInventoryManagementFrame extends Object implements Frame
    {
        private var _fullSpellList:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellInventoryManagementFrame));

        public function SpellInventoryManagementFrame()
        {
            this._fullSpellList = new Array();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get fullSpellList() : Array
        {
            return this._fullSpellList;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:SpellSetPositionAction = null;
            var _loc_3:SpellListMessage = null;
            var _loc_4:SlaveSwitchContextMessage = null;
            var _loc_5:SpellItem = null;
            var _loc_6:Breed = null;
            var _loc_7:Spell = null;
            var _loc_8:Boolean = false;
            var _loc_9:SpellItem = null;
            var _loc_10:SpellWrapper = null;
            var _loc_11:uint = 0;
            var _loc_12:SpellItem = null;
            switch(true)
            {
                case param1 is SpellSetPositionAction:
                {
                    _loc_2 = param1 as SpellSetPositionAction;
                    return true;
                }
                case param1 is SpellListMessage:
                {
                    _loc_3 = param1 as SpellListMessage;
                    this._fullSpellList = new Array();
                    for each (_loc_5 in _loc_3.spells)
                    {
                        
                        this._fullSpellList.push(SpellWrapper.create(_loc_5.position, _loc_5.spellId, _loc_5.spellLevel, true, PlayedCharacterManager.getInstance().id));
                    }
                    if (_loc_3.spellPrevisualization)
                    {
                        _loc_6 = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                        for each (_loc_7 in _loc_6.breedSpells)
                        {
                            
                            _loc_8 = false;
                            for each (_loc_9 in _loc_3.spells)
                            {
                                
                                _loc_10 = SpellWrapper.create(_loc_9.position, _loc_9.spellId, _loc_9.spellLevel, false, PlayedCharacterManager.getInstance().id);
                                _loc_11 = _loc_10.spell.spellLevels[0];
                                if (_loc_11 == _loc_7.spellLevels[0])
                                {
                                    _loc_8 = true;
                                }
                            }
                            if (!_loc_8)
                            {
                                this._fullSpellList.push(SpellWrapper.create(-1, _loc_7.id, 1, true, PlayedCharacterManager.getInstance().id));
                            }
                        }
                    }
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList;
                    PlayedCharacterManager.getInstance().playerSpellList = this._fullSpellList;
                    KernelEventsManager.getInstance().processCallback(HookList.SpellList, this._fullSpellList);
                    return true;
                }
                case param1 is SlaveSwitchContextMessage:
                {
                    _loc_4 = param1 as SlaveSwitchContextMessage;
                    this._fullSpellList = new Array();
                    for each (_loc_12 in _loc_4.slaveSpells)
                    {
                        
                        this._fullSpellList.push(SpellWrapper.create(_loc_12.position, _loc_12.spellId, _loc_12.spellLevel, true, _loc_4.slaveId));
                    }
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList;
                    CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(_loc_4.slaveId, _loc_4.slaveStats);
                    KernelEventsManager.getInstance().processCallback(HookList.SpellList, this._fullSpellList);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

    }
}
