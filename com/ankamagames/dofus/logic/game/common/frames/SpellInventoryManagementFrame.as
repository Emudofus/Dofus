package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.roleplay.actions.SpellSetPositionAction;
    import com.ankamagames.dofus.network.messages.game.inventory.spells.SpellListMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
    import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class SpellInventoryManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellInventoryManagementFrame));

        private var _fullSpellList:Array;
        private var _spellsGlobalCooldowns:Dictionary;

        public function SpellInventoryManagementFrame()
        {
            this._fullSpellList = new Array();
            this._spellsGlobalCooldowns = new Dictionary();
            super();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:SpellSetPositionAction;
            var _local_3:SpellListMessage;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:SlaveSwitchContextMessage;
            var _local_7:int;
            var _local_8:Vector.<GameFightSpellCooldown>;
            var _local_9:InventoryManagementFrame;
            var spell:SpellItem;
            var playerBreed:Breed;
            var swBreed:Spell;
            var spellInvoc:SpellItem;
            var gfsc:GameFightSpellCooldown;
            var sw:SpellWrapper;
            var spellLevel:uint;
            var gcdvalue:int;
            var spellCastManager:SpellCastInFightManager;
            var spellManager:SpellManager;
            var spellKnown:Boolean;
            switch (true)
            {
                case (msg is SpellSetPositionAction):
                    _local_2 = (msg as SpellSetPositionAction);
                    return (true);
                case (msg is SpellListMessage):
                    _local_3 = (msg as SpellListMessage);
                    _local_4 = PlayedCharacterManager.getInstance().id;
                    this._fullSpellList[_local_4] = new Array();
                    _local_5 = new Array();
                    for each (spell in _local_3.spells)
                    {
                        this._fullSpellList[_local_4].push(SpellWrapper.create(spell.position, spell.spellId, spell.spellLevel, true, PlayedCharacterManager.getInstance().id));
                        _local_5.push(spell.spellId);
                    };
                    if (_local_3.spellPrevisualization)
                    {
                        playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                        for each (swBreed in playerBreed.breedSpells)
                        {
                            if (_local_5.indexOf(swBreed.id) == -1)
                            {
                                this._fullSpellList[_local_4].push(SpellWrapper.create(1, swBreed.id, 0, true, PlayedCharacterManager.getInstance().id));
                            };
                        };
                    };
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[_local_4];
                    PlayedCharacterManager.getInstance().playerSpellList = this._fullSpellList[_local_4];
                    KernelEventsManager.getInstance().processCallback(HookList.SpellList, this._fullSpellList[_local_4]);
                    return (true);
                case (msg is SlaveSwitchContextMessage):
                    _local_6 = (msg as SlaveSwitchContextMessage);
                    _local_7 = _local_6.slaveId;
                    this._fullSpellList[_local_7] = new Array();
                    for each (spellInvoc in _local_6.slaveSpells)
                    {
                        this._fullSpellList[_local_7].push(SpellWrapper.create(spellInvoc.position, spellInvoc.spellId, spellInvoc.spellLevel, true, _local_7));
                    };
                    PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[_local_7];
                    CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(_local_7, _local_6.slaveStats);
                    if (CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(_local_7).needCooldownUpdate)
                    {
                        CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(_local_7).updateCooldowns();
                    };
                    _local_8 = this._spellsGlobalCooldowns[_local_7];
                    if (_local_8)
                    {
                        for each (gfsc in _local_8)
                        {
                            spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(_local_7);
                            gcdvalue = gfsc.cooldown;
                            spellKnown = false;
                            for each (sw in this._fullSpellList[_local_7])
                            {
                                if (sw.spellId == gfsc.spellId)
                                {
                                    spellKnown = true;
                                    spellLevel = sw.spellLevel;
                                    if (gcdvalue == -1)
                                    {
                                        gcdvalue = sw.spellLevelInfos.minCastInterval;
                                    };
                                    break;
                                };
                            };
                            if (spellKnown)
                            {
                                if (!(spellCastManager.getSpellManagerBySpellId(gfsc.spellId)))
                                {
                                    spellCastManager.castSpell(gfsc.spellId, spellLevel, [], false);
                                };
                                spellManager = spellCastManager.getSpellManagerBySpellId(gfsc.spellId);
                                spellManager.forceCooldown(gcdvalue);
                            };
                        };
                        _local_8.length = 0;
                        delete this._spellsGlobalCooldowns[_local_7];
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.SpellList, this._fullSpellList[_local_7]);
                    _local_9 = (Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame);
                    InventoryManager.getInstance().shortcutBarSpells = _local_9.getWrappersFromShortcuts(_local_6.shortcuts);
                    KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent, ShortcutBarEnum.SPELL_SHORTCUT_BAR);
                    return (false);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function getFullSpellListByOwnerId(ownerId:int):Array
        {
            return (this._fullSpellList[ownerId]);
        }

        public function addSpellGlobalCoolDownInfo(pEntityId:int, pGameFightSpellCooldown:GameFightSpellCooldown):void
        {
            if (!(this._spellsGlobalCooldowns[pEntityId]))
            {
                this._spellsGlobalCooldowns[pEntityId] = new Vector.<GameFightSpellCooldown>(0);
            };
            this._spellsGlobalCooldowns[pEntityId].push(pGameFightSpellCooldown);
        }

        public function deleteSpellsGlobalCoolDownsData():void
        {
            var id:*;
            for (id in this._spellsGlobalCooldowns)
            {
                this._spellsGlobalCooldowns[id].length = 0;
                delete this._spellsGlobalCooldowns[id];
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

