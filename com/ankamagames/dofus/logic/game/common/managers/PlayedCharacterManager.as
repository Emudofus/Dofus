package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import flash.geom.Point;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class PlayedCharacterManager extends Object implements IDestroyable
   {
      
      public function PlayedCharacterManager() {
         this.lastCoord = new Point(0,0);
         super();
         if(_self != null)
         {
            throw new SingletonError("PlayedCharacterManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static var _self:PlayedCharacterManager;
      
      protected static const _log:Logger;
      
      public static function getInstance() : PlayedCharacterManager {
         if(_self == null)
         {
            _self = new PlayedCharacterManager();
         }
         return _self;
      }
      
      private var _isPartyLeader:Boolean = false;
      
      private var _followingPlayerId:int = -1;
      
      public function get id() : int {
         if(this.infos)
         {
            return this.infos.id;
         }
         return 0;
      }
      
      public function set id(id:int) : void {
         if(this.infos)
         {
            this.infos.id = id;
         }
      }
      
      public var infos:CharacterBaseInformations;
      
      public var restrictions:ActorRestrictionsInformations;
      
      public var realEntityLook:EntityLook;
      
      public var characteristics:CharacterCharacteristicsInformations;
      
      public var spellsInventory:Array;
      
      public var playerSpellList:Array;
      
      public var playerShortcutList:Array;
      
      public var inventory:Vector.<ItemWrapper>;
      
      public var currentWeapon:WeaponWrapper;
      
      public var inventoryWeight:uint;
      
      public var inventoryWeightMax:uint;
      
      public var currentMap:WorldPointWrapper;
      
      public var currentSubArea:SubArea;
      
      public var jobs:Array;
      
      public var isInExchange:Boolean = false;
      
      public var isInHisHouse:Boolean = false;
      
      public var isInHouse:Boolean = false;
      
      public var lastCoord:Point;
      
      public var isInParty:Boolean = false;
      
      public var state:uint;
      
      public var publicMode:Boolean = false;
      
      public var isRidding:Boolean = false;
      
      public var isPetsMounting:Boolean = false;
      
      public var hasCompanion:Boolean = false;
      
      public var mount:MountData;
      
      public var currentSummonedCreature:uint = 0;
      
      public var currentSummonedBomb:uint = 0;
      
      public var isFighting:Boolean = false;
      
      public var teamId:int = 0;
      
      public var isSpectator:Boolean = false;
      
      public var experiencePercent:int = 0;
      
      public var achievementPoints:int = 0;
      
      public var achievementPercent:int = 0;
      
      public function get cantMinimize() : Boolean {
         return this.restrictions.cantMinimize;
      }
      
      public function get forceSlowWalk() : Boolean {
         return this.restrictions.forceSlowWalk;
      }
      
      public function get cantUseTaxCollector() : Boolean {
         return this.restrictions.cantUseTaxCollector;
      }
      
      public function get cantTrade() : Boolean {
         return this.restrictions.cantTrade;
      }
      
      public function get cantRun() : Boolean {
         return this.restrictions.cantRun;
      }
      
      public function get cantMove() : Boolean {
         return this.restrictions.cantMove;
      }
      
      public function get cantBeChallenged() : Boolean {
         return this.restrictions.cantBeChallenged;
      }
      
      public function get cantBeAttackedByMutant() : Boolean {
         return this.restrictions.cantBeAttackedByMutant;
      }
      
      public function get cantBeAggressed() : Boolean {
         return this.restrictions.cantBeAggressed;
      }
      
      public function get cantAttack() : Boolean {
         return this.restrictions.cantAttack;
      }
      
      public function get cantAgress() : Boolean {
         return this.restrictions.cantAggress;
      }
      
      public function get cantChallenge() : Boolean {
         return this.restrictions.cantChallenge;
      }
      
      public function get cantExchange() : Boolean {
         return this.restrictions.cantExchange;
      }
      
      public function get cantChat() : Boolean {
         return this.restrictions.cantChat;
      }
      
      public function get cantBeMerchant() : Boolean {
         return this.restrictions.cantBeMerchant;
      }
      
      public function get cantUseObject() : Boolean {
         return this.restrictions.cantUseObject;
      }
      
      public function get cantUseInteractiveObject() : Boolean {
         return this.restrictions.cantUseInteractive;
      }
      
      public function get cantSpeakToNpc() : Boolean {
         return this.restrictions.cantSpeakToNPC;
      }
      
      public function get cantChangeZone() : Boolean {
         return this.restrictions.cantChangeZone;
      }
      
      public function get cantAttackMonster() : Boolean {
         return this.restrictions.cantAttackMonster;
      }
      
      public function get cantWalkInEightDirections() : Boolean {
         return this.restrictions.cantWalk8Directions;
      }
      
      public function get currentWorldMap() : WorldMap {
         return this.currentSubArea.worldmap;
      }
      
      public function get isIncarnation() : Boolean {
         return EntitiesLooksManager.getInstance().isIncarnation(this.id);
      }
      
      public function get isMutated() : Boolean {
         var l:* = 0;
         var i:* = 0;
         var rpBuffs:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("roleplayBuff").content;
         if(rpBuffs)
         {
            l = rpBuffs.length;
            i = 0;
            while(i < l)
            {
               if((rpBuffs[i]) && (rpBuffs[i].typeId == 27) && (rpBuffs[i].position == CharacterInventoryPositionEnum.INVENTORY_POSITION_MUTATION))
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
      
      public function set isPartyLeader(b:Boolean) : void {
         if(!this.isInParty)
         {
            this._isPartyLeader = false;
         }
         else
         {
            this._isPartyLeader = b;
         }
      }
      
      public function get isPartyLeader() : Boolean {
         return this._isPartyLeader;
      }
      
      public function get isGhost() : Boolean {
         var isGhost:* = false;
         var breed:Breed = null;
         var look:TiphonEntityLook = EntityLookAdapter.fromNetwork(this.infos.entityLook);
         var isCreature:Boolean = false;
         var breeds:Array = Breed.getBreeds();
         for each(breed in breeds)
         {
            if(breed.creatureBonesId == look.getBone())
            {
               isCreature = true;
               break;
            }
         }
         return (!look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0)) && (!isCreature) && (!(look.getBone() == 1)) && (!this.isIncarnation);
      }
      
      public function get artworkId() : uint {
         return this.infos.entityLook.bonesId == 1?this.infos.entityLook.skins[0]:this.infos.entityLook.bonesId;
      }
      
      public function get followingPlayerId() : int {
         return this._followingPlayerId;
      }
      
      public function set followingPlayerId(pPlayerId:int) : void {
         this._followingPlayerId = pPlayerId;
      }
      
      public function destroy() : void {
         _self = null;
      }
      
      public function get tiphonEntityLook() : TiphonEntityLook {
         return EntityLookAdapter.fromNetwork(this.infos.entityLook);
      }
      
      public function resetSummonedCreature() : void {
         this.currentSummonedCreature = 0;
      }
      
      public function addSummonedCreature() : void {
         this.currentSummonedCreature = this.currentSummonedCreature + 1;
      }
      
      public function removeSummonedCreature() : void {
         if(this.currentSummonedCreature > 0)
         {
            this.currentSummonedCreature = this.currentSummonedCreature - 1;
         }
      }
      
      private function getMaxSummonedCreature() : uint {
         return this.characteristics.summonableCreaturesBoost.base + this.characteristics.summonableCreaturesBoost.objectsAndMountBonus + this.characteristics.summonableCreaturesBoost.alignGiftBonus + this.characteristics.summonableCreaturesBoost.contextModif;
      }
      
      private function getCurrentSummonedCreature() : uint {
         return this.currentSummonedCreature;
      }
      
      public function canSummon() : Boolean {
         return this.getMaxSummonedCreature() > this.getCurrentSummonedCreature();
      }
      
      public function resetSummonedBomb() : void {
         this.currentSummonedBomb = 0;
      }
      
      public function addSummonedBomb() : void {
         this.currentSummonedBomb = this.currentSummonedBomb + 1;
      }
      
      public function removeSummonedBomb() : void {
         if(this.currentSummonedBomb > 0)
         {
            this.currentSummonedBomb = this.currentSummonedBomb - 1;
         }
      }
      
      private function getMaxSummonedBomb() : uint {
         return 3;
      }
      
      public function canBomb() : Boolean {
         return this.getMaxSummonedBomb() > this.currentSummonedBomb;
      }
      
      public function levelDiff(targetLevel:uint) : int {
         var diff:* = 0;
         var playerLevel:int = this.infos.level;
         var type:int = 1;
         if(targetLevel < playerLevel)
         {
            type = -1;
         }
         if(Math.abs(targetLevel - playerLevel) > 20)
         {
            diff = 1 * type;
         }
         else if(targetLevel < playerLevel)
         {
            if(targetLevel / playerLevel < 1.2)
            {
               diff = 0;
            }
            else
            {
               diff = 1 * type;
            }
         }
         else if(playerLevel / targetLevel < 1.2)
         {
            diff = 0;
         }
         else
         {
            diff = 1 * type;
         }
         
         
         return diff;
      }
   }
}
