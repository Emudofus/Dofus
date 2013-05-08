package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellSetPositionAction;
   import com.ankamagames.dofus.network.messages.game.inventory.spells.SpellListMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.spells.SlaveSwitchContextMessage;
   import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;


   public class SpellInventoryManagementFrame extends Object implements Frame
   {
         

      public function SpellInventoryManagementFrame() {
         this._fullSpellList=new Array();
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellInventoryManagementFrame));

      private var _fullSpellList:Array;

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function get fullSpellList() : Array {
         return this._fullSpellList;
      }

      public function pushed() : Boolean {
         return true;
      }

      public function process(msg:Message) : Boolean {
         var sspa:SpellSetPositionAction = null;
         var slmsg:SpellListMessage = null;
         var idsList:Array = null;
         var slsmsg:SlaveSwitchContextMessage = null;
         var spell:SpellItem = null;
         var playerBreed:Breed = null;
         var swBreed:Spell = null;
         var spellInvoc:SpellItem = null;
         switch(true)
         {
            case msg is SpellSetPositionAction:
               sspa=msg as SpellSetPositionAction;
               return true;
            case msg is SpellListMessage:
               slmsg=msg as SpellListMessage;
               this._fullSpellList=new Array();
               idsList=new Array();
               for each (spell in slmsg.spells)
               {
                  this._fullSpellList.push(SpellWrapper.create(spell.position,spell.spellId,spell.spellLevel,true,PlayedCharacterManager.getInstance().id));
                  idsList.push(spell.spellId);
               }
               if(slmsg.spellPrevisualization)
               {
                  playerBreed=Breed.getBreedById(PlayedCharacterManager.getInstance().infos.breed);
                  for each (swBreed in playerBreed.breedSpells)
                  {
                     if(idsList.indexOf(swBreed.id)==-1)
                     {
                        this._fullSpellList.push(SpellWrapper.create(1,swBreed.id,0,true,PlayedCharacterManager.getInstance().id));
                     }
                  }
               }
               PlayedCharacterManager.getInstance().spellsInventory=this._fullSpellList;
               PlayedCharacterManager.getInstance().playerSpellList=this._fullSpellList;
               KernelEventsManager.getInstance().processCallback(HookList.SpellList,this._fullSpellList);
               return true;
            case msg is SlaveSwitchContextMessage:
               slsmsg=msg as SlaveSwitchContextMessage;
               this._fullSpellList=new Array();
               for each (spellInvoc in slsmsg.slaveSpells)
               {
                  this._fullSpellList.push(SpellWrapper.create(spellInvoc.position,spellInvoc.spellId,spellInvoc.spellLevel,true,slsmsg.slaveId));
               }
               PlayedCharacterManager.getInstance().spellsInventory=this._fullSpellList;
               CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(slsmsg.slaveId,slsmsg.slaveStats);
               KernelEventsManager.getInstance().processCallback(HookList.SpellList,this._fullSpellList);
               return true;
            default:
               return false;
         }
      }

      public function pulled() : Boolean {
         return true;
      }
   }

}