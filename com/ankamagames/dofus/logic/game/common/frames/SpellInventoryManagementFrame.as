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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
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
                    _loc_4 = new Array();
                    for each (_loc_6 in _loc_3.spells)
                    {
                        
                        this._fullSpellList.push(SpellWrapper.create(_loc_6.position, _loc_6.spellId, _loc_6.spellLevel, true, PlayedCharacterManager.getInstance().id));
                        _loc_4.push(_loc_6.spellId);
                    }
                    if (_loc_3.spellPrevisualization)
                    {
                        _loc_7 = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                        for each (_loc_8 in _loc_7.breedSpells)
                        {
                            
                            if (_loc_4.indexOf(_loc_8.id) == -1)
                            {
                                this._fullSpellList.push(SpellWrapper.create(1, _loc_8.id, 1, true, PlayedCharacterManager.getInstance().id));
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
                    _loc_5 = param1 as SlaveSwitchContextMessage;
                    this._fullSpellList = new Array();
                    for each (_loc_9 in _loc_5.slaveSpells)
                    {
                        
                        this._fullSpellList.push(SpellWrapper.create(_loc_9.position, _loc_9.spellId, _loc_9.spellLevel, true, _loc_5.slaveId));
                    }
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList;
                    CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(_loc_5.slaveId, _loc_5.slaveStats);
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
