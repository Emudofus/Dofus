package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellSetPositionAction;
   import com.ankamagames.dofus.network.messages.game.inventory.spells.SpellListMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
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
   
   public class SpellInventoryManagementFrame extends Object implements Frame
   {
      
      public function SpellInventoryManagementFrame() {
         this._fullSpellList = new Array();
         this._spellsGlobalCooldowns = new Dictionary();
         super();
      }
      
      protected static const _log:Logger;
      
      private var _fullSpellList:Array;
      
      private var _spellsGlobalCooldowns:Dictionary;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var sspa:SpellSetPositionAction = null;
         var slmsg:SpellListMessage = null;
         var playerId:* = 0;
         var idsList:Array = null;
         var sscmsg:SlaveSwitchContextMessage = null;
         var slaveId:* = 0;
         var sgcds:Vector.<GameFightSpellCooldown> = null;
         var imf:InventoryManagementFrame = null;
         var spell:SpellItem = null;
         var playerBreed:Breed = null;
         var swBreed:Spell = null;
         var spellInvoc:SpellItem = null;
         var gfsc:GameFightSpellCooldown = null;
         var sw:SpellWrapper = null;
         var spellLevel:uint = 0;
         var gcdvalue:* = 0;
         var spellCastManager:SpellCastInFightManager = null;
         var spellManager:SpellManager = null;
         var spellKnown:* = false;
         switch(true)
         {
            case msg is SpellSetPositionAction:
               sspa = msg as SpellSetPositionAction;
               return true;
            case msg is SpellListMessage:
               slmsg = msg as SpellListMessage;
               playerId = PlayedCharacterManager.getInstance().id;
               this._fullSpellList[playerId] = new Array();
               idsList = new Array();
               for each(spell in slmsg.spells)
               {
                  this._fullSpellList[playerId].push(SpellWrapper.create(spell.position,spell.spellId,spell.spellLevel,true,PlayedCharacterManager.getInstance().id));
                  idsList.push(spell.spellId);
               }
               if(slmsg.spellPrevisualization)
               {
                  playerBreed = Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                  for each(swBreed in playerBreed.breedSpells)
                  {
                     if(idsList.indexOf(swBreed.id) == -1)
                     {
                        this._fullSpellList[playerId].push(SpellWrapper.create(1,swBreed.id,0,true,PlayedCharacterManager.getInstance().id));
                     }
                  }
               }
               PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[playerId];
               PlayedCharacterManager.getInstance().playerSpellList = this._fullSpellList[playerId];
               KernelEventsManager.getInstance().processCallback(HookList.SpellList,this._fullSpellList[playerId]);
               return true;
            case msg is SlaveSwitchContextMessage:
               sscmsg = msg as SlaveSwitchContextMessage;
               slaveId = sscmsg.slaveId;
               this._fullSpellList[slaveId] = new Array();
               for each(spellInvoc in sscmsg.slaveSpells)
               {
                  this._fullSpellList[slaveId].push(SpellWrapper.create(spellInvoc.position,spellInvoc.spellId,spellInvoc.spellLevel,true,slaveId));
               }
               PlayedCharacterManager.getInstance().spellsInventory = this._fullSpellList[slaveId];
               CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(slaveId,sscmsg.slaveStats);
               if(CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(slaveId).needCooldownUpdate)
               {
                  CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(slaveId).updateCooldowns();
               }
               sgcds = this._spellsGlobalCooldowns[slaveId];
               if(sgcds)
               {
                  for each(gfsc in sgcds)
                  {
                     spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(slaveId);
                     gcdvalue = gfsc.cooldown;
                     spellKnown = false;
                     for each(sw in this._fullSpellList[slaveId])
                     {
                        if(sw.spellId == gfsc.spellId)
                        {
                           spellKnown = true;
                           spellLevel = sw.spellLevel;
                           if(gcdvalue == -1)
                           {
                              gcdvalue = sw.spellLevelInfos.minCastInterval;
                           }
                           break;
                        }
                     }
                     if(spellKnown)
                     {
                        if(!spellCastManager.getSpellManagerBySpellId(gfsc.spellId))
                        {
                           spellCastManager.castSpell(gfsc.spellId,spellLevel,[],false);
                        }
                        spellManager = spellCastManager.getSpellManagerBySpellId(gfsc.spellId);
                        spellManager.forceCooldown(gcdvalue);
                     }
                  }
                  sgcds.length = 0;
                  delete this._spellsGlobalCooldowns[slaveId];
               }
               KernelEventsManager.getInstance().processCallback(HookList.SpellList,this._fullSpellList[slaveId]);
               imf = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
               InventoryManager.getInstance().shortcutBarSpells = imf.getWrappersFromShortcuts(sscmsg.shortcuts);
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,ShortcutBarEnum.SPELL_SHORTCUT_BAR);
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function getFullSpellListByOwnerId(ownerId:int) : Array {
         return this._fullSpellList[ownerId];
      }
      
      public function addSpellGlobalCoolDownInfo(pEntityId:int, pGameFightSpellCooldown:GameFightSpellCooldown) : void {
         if(!this._spellsGlobalCooldowns[pEntityId])
         {
            this._spellsGlobalCooldowns[pEntityId] = new Vector.<GameFightSpellCooldown>(0);
         }
         this._spellsGlobalCooldowns[pEntityId].push(pGameFightSpellCooldown);
      }
      
      public function deleteSpellsGlobalCoolDownsData() : void {
         var id:* = undefined;
         for(id in this._spellsGlobalCooldowns)
         {
            this._spellsGlobalCooldowns[id].length = 0;
            delete this._spellsGlobalCooldowns[id];
         }
      }
   }
}
