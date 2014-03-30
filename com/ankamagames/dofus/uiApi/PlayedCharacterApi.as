package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.TinselFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.types.data.PlayerSetInfo;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   
   public class PlayedCharacterApi extends Object implements IApi
   {
      
      public function PlayedCharacterApi() {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterApi));
      
      public static function characteristics() : CharacterCharacteristicsInformations {
         return PlayedCharacterManager.getInstance().characteristics;
      }
      
      public static function getPlayedCharacterInfo() : Object {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         if(!i)
         {
            return null;
         }
         var o:Object = new Object();
         o.id = i.id;
         o.breed = i.breed;
         o.level = i.level;
         o.sex = i.sex;
         o.name = i.name;
         o.entityLook = EntityLookAdapter.fromNetwork(i.entityLook);
         o.realEntityLook = o.entityLook;
         if((isCreature()) && (PlayedCharacterManager.getInstance().realEntityLook))
         {
            o.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
         }
         var ridderLook:TiphonEntityLook = TiphonEntityLook(o.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(ridderLook)
         {
            if(ridderLook.getBone() == 2)
            {
               ridderLook.setBone(1);
            }
            o.entityLook = ridderLook;
         }
         return o;
      }
      
      public static function getCurrentEntityLook() : Object {
         var look:TiphonEntityLook = null;
         var entity:AnimatedCharacter = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
         if(entity)
         {
            look = entity.look.clone();
         }
         else
         {
            look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
         }
         return look;
      }
      
      public static function getInventory() : Vector.<ItemWrapper> {
         return InventoryManager.getInstance().realInventory;
      }
      
      public static function getEquipment() : Array {
         var item:* = undefined;
         var equipment:Array = new Array();
         for each (item in PlayedCharacterManager.getInstance().inventory)
         {
            if(item.position <= 15)
            {
               equipment.push(item);
            }
         }
         return equipment;
      }
      
      public static function getSpellInventory() : Array {
         return PlayedCharacterManager.getInstance().spellsInventory;
      }
      
      public static function getJobs() : Array {
         return PlayedCharacterManager.getInstance().jobs;
      }
      
      public static function getMount() : Object {
         return PlayedCharacterManager.getInstance().mount;
      }
      
      public static function getTitle() : Title {
         var title:Title = null;
         var playerInfo:GameRolePlayCharacterInformations = null;
         var option:* = undefined;
         var title2:Title = null;
         var titleId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentTitle;
         if(titleId)
         {
            title = Title.getTitleById(titleId);
            return title;
         }
         playerInfo = getEntityInfos();
         if((playerInfo) && (playerInfo.humanoidInfo))
         {
            for each (option in playerInfo.humanoidInfo.options)
            {
               if(option is HumanOptionTitle)
               {
                  titleId = option.titleId;
               }
            }
            title2 = Title.getTitleById(titleId);
            return title2;
         }
         return null;
      }
      
      public static function getOrnament() : Ornament {
         var ornament:Ornament = null;
         var ornamentId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentOrnament;
         if(ornamentId)
         {
            ornament = Ornament.getOrnamentById(ornamentId);
            return ornament;
         }
         return null;
      }
      
      public static function getKnownTitles() : Vector.<uint> {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownTitles;
      }
      
      public static function getKnownOrnaments() : Vector.<uint> {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownOrnaments;
      }
      
      public static function titlesOrnamentsAskedBefore() : Boolean {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).titlesOrnamentsAskedBefore;
      }
      
      public static function getEntityInfos() : GameRolePlayCharacterInformations {
         var entitiesFrame:AbstractEntitiesFrame = null;
         if(isInFight())
         {
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame;
         }
         else
         {
            entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
         }
         if(!entitiesFrame)
         {
            return null;
         }
         var playerInfo:GameRolePlayCharacterInformations = entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayCharacterInformations;
         return playerInfo;
      }
      
      public static function getEntityTooltipInfos() : CharacterTooltipInformation {
         var playerInfo:GameRolePlayCharacterInformations = getEntityInfos();
         if(!playerInfo)
         {
            return null;
         }
         var tooltipInfos:CharacterTooltipInformation = new CharacterTooltipInformation(playerInfo,0);
         return tooltipInfos;
      }
      
      public static function inventoryWeight() : uint {
         return PlayedCharacterManager.getInstance().inventoryWeight;
      }
      
      public static function inventoryWeightMax() : uint {
         return PlayedCharacterManager.getInstance().inventoryWeightMax;
      }
      
      public static function isIncarnation() : Boolean {
         return PlayedCharacterManager.getInstance().isIncarnation;
      }
      
      public static function isMutated() : Boolean {
         return PlayedCharacterManager.getInstance().isMutated;
      }
      
      public static function isInHouse() : Boolean {
         return PlayedCharacterManager.getInstance().isInHouse;
      }
      
      public static function isInExchange() : Boolean {
         return PlayedCharacterManager.getInstance().isInExchange;
      }
      
      public static function isInFight() : Boolean {
         return !(Kernel.getWorker().getFrame(FightContextFrame) == null);
      }
      
      public static function isInPreFight() : Boolean {
         return !(Kernel.getWorker().getFrame(FightPreparationFrame) == null);
      }
      
      public static function isInParty() : Boolean {
         return PlayedCharacterManager.getInstance().isInParty;
      }
      
      public static function isPartyLeader() : Boolean {
         return PlayedCharacterManager.getInstance().isPartyLeader;
      }
      
      public static function isRidding() : Boolean {
         return PlayedCharacterManager.getInstance().isRidding;
      }
      
      public static function isPetsMounting() : Boolean {
         return PlayedCharacterManager.getInstance().isPetsMounting;
      }
      
      public static function hasCompanion() : Boolean {
         return PlayedCharacterManager.getInstance().hasCompanion;
      }
      
      public static function id() : uint {
         return PlayedCharacterManager.getInstance().id;
      }
      
      public static function restrictions() : ActorRestrictionsInformations {
         return PlayedCharacterManager.getInstance().restrictions;
      }
      
      public static function isMutant() : Boolean {
         var rcf:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var infos:GameRolePlayActorInformations = rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
         return infos is GameRolePlayMutantInformations;
      }
      
      public static function publicMode() : Boolean {
         return PlayedCharacterManager.getInstance().publicMode;
      }
      
      public static function artworkId() : int {
         return PlayedCharacterManager.getInstance().artworkId;
      }
      
      public static function isCreature() : Boolean {
         return EntitiesLooksManager.getInstance().isCreature(id());
      }
      
      public static function getBone() : uint {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         return EntityLookAdapter.fromNetwork(i.entityLook).getBone();
      }
      
      public static function getSkin() : uint {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         if((EntityLookAdapter.fromNetwork(i.entityLook)) && (EntityLookAdapter.fromNetwork(i.entityLook).getSkins()) && (EntityLookAdapter.fromNetwork(i.entityLook).getSkins().length > 0))
         {
            return EntityLookAdapter.fromNetwork(i.entityLook).getSkins()[0];
         }
         return 0;
      }
      
      public static function getColors() : Object {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         return EntityLookAdapter.fromNetwork(i.entityLook).getColors();
      }
      
      public static function getSubentityColors() : Object {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         var subTel:TiphonEntityLook = EntityLookAdapter.fromNetwork(i.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if((!subTel) && (PlayedCharacterManager.getInstance().realEntityLook))
         {
            subTel = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         }
         return subTel?subTel.getColors():null;
      }
      
      public static function getAlignmentSide() : int {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
      }
      
      public static function getAlignmentValue() : uint {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentValue;
      }
      
      public static function getAlignmentAggressableStatus() : uint {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable;
      }
      
      public static function getAlignmentGrade() : uint {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
      }
      
      public static function getMaxSummonedCreature() : uint {
         return PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.base + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.objectsAndMountBonus + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.alignGiftBonus + PlayedCharacterManager.getInstance().characteristics.summonableCreaturesBoost.contextModif;
      }
      
      public static function getCurrentSummonedCreature() : uint {
         return PlayedCharacterManager.getInstance().currentSummonedCreature;
      }
      
      public static function canSummon() : Boolean {
         return getMaxSummonedCreature() >= getCurrentSummonedCreature() + 1;
      }
      
      public static function getSpell(spellId:uint) : SpellWrapper {
         return CurrentPlayedFighterManager.getInstance().getSpellById(spellId);
      }
      
      public static function canCastThisSpell(spellId:uint, lvl:uint) : Boolean {
         return CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId,lvl);
      }
      
      public static function canCastThisSpellOnTarget(spellId:uint, lvl:uint, pTargetId:int) : Boolean {
         return CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId,lvl,pTargetId);
      }
      
      public static function getSpellModification(spellId:uint, carac:int) : int {
         var modif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(spellId,carac);
         if((modif) && (modif.value))
         {
            return modif.value.alignGiftBonus + modif.value.base + modif.value.contextModif + modif.value.objectsAndMountBonus;
         }
         return 0;
      }
      
      public static function isInHisHouse() : Boolean {
         return PlayedCharacterManager.getInstance().isInHisHouse;
      }
      
      public static function getPlayerHouses() : Vector.<AccountHouseInformations> {
         return (Kernel.getWorker().getFrame(MiscFrame) as MiscFrame).accountHouses;
      }
      
      public static function currentMap() : WorldPointWrapper {
         return PlayedCharacterManager.getInstance().currentMap;
      }
      
      public static function currentSubArea() : SubArea {
         return PlayedCharacterManager.getInstance().currentSubArea;
      }
      
      public static function state() : uint {
         return PlayedCharacterManager.getInstance().state;
      }
      
      public static function isAlive() : Boolean {
         return PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING;
      }
      
      public static function getFollowingPlayerId() : int {
         return PlayedCharacterManager.getInstance().followingPlayerId;
      }
      
      public static function getPlayerSet(objectGID:uint) : PlayerSetInfo {
         return PlayedCharacterUpdatesFrame(Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame)).getPlayerSet(objectGID);
      }
      
      public static function getWeapon() : WeaponWrapper {
         return PlayedCharacterManager.getInstance().currentWeapon;
      }
      
      public static function getExperienceBonusPercent() : int {
         return PlayedCharacterManager.getInstance().experiencePercent;
      }
      
      public static function knowSpell(pSpellId:uint) : int {
         var obtentionSpellLevel:uint = 0;
         var playerSpellLevel:uint = 0;
         var sp:SpellWrapper = null;
         var disable:* = false;
         var spellWrapper:SpellWrapper = null;
         var spellLevelZero:SpellLevel = null;
         var spell:Spell = Spell.getSpellById(pSpellId);
         var spellLevel:SpellLevel = SpellLevel.getLevelById(pSpellId);
         if(pSpellId == 0)
         {
            obtentionSpellLevel = 0;
         }
         else
         {
            spellLevelZero = spell.getSpellLevel(1);
            obtentionSpellLevel = spellLevelZero.minPlayerLevel;
         }
         var spellInv:Array = getSpellInventory();
         for each (sp in spellInv)
         {
            if(sp.spellId == pSpellId)
            {
               playerSpellLevel = sp.spellLevel;
            }
         }
         disable = true;
         for each (spellWrapper in spellInv)
         {
            if(spellWrapper.spellId == pSpellId)
            {
               disable = false;
            }
         }
         if(disable)
         {
            return -1;
         }
         return playerSpellLevel;
      }
   }
}
