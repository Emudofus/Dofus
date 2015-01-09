package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import avmplus.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
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
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.logic.common.frames.MiscFrame;
    import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
    import com.ankamagames.dofus.types.data.PlayerSetInfo;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.datacenter.spells.Spell;

    public class PlayedCharacterApi implements IApi 
    {

        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterApi));

        public function PlayedCharacterApi()
        {
            MEMORY_LOG[this] = 1;
        }

        [Untrusted]
        public static function characteristics():CharacterCharacteristicsInformations
        {
            return (PlayedCharacterManager.getInstance().characteristics);
        }

        [Untrusted]
        public static function getPlayedCharacterInfo():Object
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            if (!(i))
            {
                return (null);
            };
            var o:Object = new Object();
            o.id = i.id;
            o.breed = i.breed;
            o.level = i.level;
            o.sex = i.sex;
            o.name = i.name;
            o.entityLook = EntityLookAdapter.fromNetwork(i.entityLook);
            o.realEntityLook = o.entityLook;
            if (((isCreature()) && (PlayedCharacterManager.getInstance().realEntityLook)))
            {
                o.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
            };
            var ridderLook:TiphonEntityLook = TiphonEntityLook(o.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (ridderLook)
            {
                if (ridderLook.getBone() == 2)
                {
                    ridderLook.setBone(1);
                };
                o.entityLook = ridderLook;
            };
            return (o);
        }

        [Untrusted]
        public static function getCurrentEntityLook():Object
        {
            var look:TiphonEntityLook;
            var entity:AnimatedCharacter = (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter);
            if (entity)
            {
                look = entity.look.clone();
            }
            else
            {
                look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook);
            };
            return (look);
        }

        [Untrusted]
        public static function getInventory():Vector.<ItemWrapper>
        {
            return (InventoryManager.getInstance().realInventory);
        }

        [Untrusted]
        public static function getEquipment():Array
        {
            var item:*;
            var equipment:Array = new Array();
            for each (item in PlayedCharacterManager.getInstance().inventory)
            {
                if (item.position <= 15)
                {
                    equipment.push(item);
                };
            };
            return (equipment);
        }

        [Untrusted]
        public static function getSpellInventory():Array
        {
            return (PlayedCharacterManager.getInstance().spellsInventory);
        }

        [Untrusted]
        public static function getJobs():Array
        {
            return (PlayedCharacterManager.getInstance().jobs);
        }

        [Untrusted]
        public static function getMount():Object
        {
            return (PlayedCharacterManager.getInstance().mount);
        }

        [Untrusted]
        public static function getTitle():Title
        {
            var title:Title;
            var _local_3:GameRolePlayCharacterInformations;
            var option:*;
            var title2:Title;
            var titleId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentTitle;
            if (titleId)
            {
                title = Title.getTitleById(titleId);
                return (title);
            };
            _local_3 = getEntityInfos();
            if (((_local_3) && (_local_3.humanoidInfo)))
            {
                for each (option in _local_3.humanoidInfo.options)
                {
                    if ((option is HumanOptionTitle))
                    {
                        titleId = option.titleId;
                    };
                };
                title2 = Title.getTitleById(titleId);
                return (title2);
            };
            return (null);
        }

        [Untrusted]
        public static function getOrnament():Ornament
        {
            var ornament:Ornament;
            var ornamentId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentOrnament;
            if (ornamentId)
            {
                ornament = Ornament.getOrnamentById(ornamentId);
                return (ornament);
            };
            return (null);
        }

        [Untrusted]
        public static function getKnownTitles():Vector.<uint>
        {
            return ((Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownTitles);
        }

        [Untrusted]
        public static function getKnownOrnaments():Vector.<uint>
        {
            return ((Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownOrnaments);
        }

        [Untrusted]
        public static function titlesOrnamentsAskedBefore():Boolean
        {
            return ((Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).titlesOrnamentsAskedBefore);
        }

        [Untrusted]
        public static function getEntityInfos():GameRolePlayCharacterInformations
        {
            var entitiesFrame:AbstractEntitiesFrame;
            if (isInFight())
            {
                entitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame);
            }
            else
            {
                entitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame);
            };
            if (!(entitiesFrame))
            {
                return (null);
            };
            var playerInfo:GameRolePlayCharacterInformations = (entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayCharacterInformations);
            return (playerInfo);
        }

        [Untrusted]
        public static function getEntityTooltipInfos():CharacterTooltipInformation
        {
            var playerInfo:GameRolePlayCharacterInformations = getEntityInfos();
            if (!(playerInfo))
            {
                return (null);
            };
            var tooltipInfos:CharacterTooltipInformation = new CharacterTooltipInformation(playerInfo, 0);
            return (tooltipInfos);
        }

        [Untrusted]
        public static function inventoryWeight():uint
        {
            return (PlayedCharacterManager.getInstance().inventoryWeight);
        }

        [Untrusted]
        public static function inventoryWeightMax():uint
        {
            return (PlayedCharacterManager.getInstance().inventoryWeightMax);
        }

        [Untrusted]
        public static function isIncarnation():Boolean
        {
            return (PlayedCharacterManager.getInstance().isIncarnation);
        }

        [Untrusted]
        public static function isMutated():Boolean
        {
            return (PlayedCharacterManager.getInstance().isMutated);
        }

        [Untrusted]
        public static function isInHouse():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInHouse);
        }

        [Untrusted]
        public static function isInExchange():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInExchange);
        }

        [Untrusted]
        public static function isInFight():Boolean
        {
            return (!((Kernel.getWorker().getFrame(FightContextFrame) == null)));
        }

        [Untrusted]
        public static function isInPreFight():Boolean
        {
            return (!((Kernel.getWorker().getFrame(FightPreparationFrame) == null)));
        }

        [Untrusted]
        public static function isInParty():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInParty);
        }

        [Untrusted]
        public static function isPartyLeader():Boolean
        {
            return (PlayedCharacterManager.getInstance().isPartyLeader);
        }

        [Untrusted]
        public static function isRidding():Boolean
        {
            return (PlayedCharacterManager.getInstance().isRidding);
        }

        [Untrusted]
        public static function isPetsMounting():Boolean
        {
            return (PlayedCharacterManager.getInstance().isPetsMounting);
        }

        [Untrusted]
        public static function hasCompanion():Boolean
        {
            return (PlayedCharacterManager.getInstance().hasCompanion);
        }

        [Untrusted]
        public static function id():uint
        {
            return (PlayedCharacterManager.getInstance().id);
        }

        [Untrusted]
        public static function restrictions():ActorRestrictionsInformations
        {
            return (PlayedCharacterManager.getInstance().restrictions);
        }

        [Untrusted]
        public static function isMutant():Boolean
        {
            var rcf:RoleplayContextFrame = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
            var infos:GameRolePlayActorInformations = (rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations);
            return ((infos is GameRolePlayMutantInformations));
        }

        [Untrusted]
        public static function publicMode():Boolean
        {
            return (PlayedCharacterManager.getInstance().publicMode);
        }

        [Untrusted]
        public static function artworkId():int
        {
            return (PlayedCharacterManager.getInstance().artworkId);
        }

        [Untrusted]
        public static function isCreature():Boolean
        {
            return (EntitiesLooksManager.getInstance().isCreature(id()));
        }

        [Untrusted]
        public static function getBone():uint
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            return (EntityLookAdapter.fromNetwork(i.entityLook).getBone());
        }

        [Untrusted]
        public static function getSkin():uint
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            if (((((EntityLookAdapter.fromNetwork(i.entityLook)) && (EntityLookAdapter.fromNetwork(i.entityLook).getSkins()))) && ((EntityLookAdapter.fromNetwork(i.entityLook).getSkins().length > 0))))
            {
                return (EntityLookAdapter.fromNetwork(i.entityLook).getSkins()[0]);
            };
            return (0);
        }

        [Untrusted]
        public static function getColors():Object
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            return (EntityLookAdapter.fromNetwork(i.entityLook).getColors());
        }

        [Untrusted]
        public static function getSubentityColors():Object
        {
            var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
            var subTel:TiphonEntityLook = EntityLookAdapter.fromNetwork(i.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            if (((!(subTel)) && (PlayedCharacterManager.getInstance().realEntityLook)))
            {
                subTel = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0);
            };
            return (((subTel) ? subTel.getColors() : null));
        }

        [Untrusted]
        public static function getAlignmentSide():int
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide);
        }

        [Untrusted]
        public static function getAlignmentValue():uint
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentValue);
        }

        [Untrusted]
        public static function getAlignmentAggressableStatus():uint
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable);
        }

        [Untrusted]
        public static function getAlignmentGrade():uint
        {
            return (PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade);
        }

        [Untrusted]
        public static function getMaxSummonedCreature():uint
        {
            return (CurrentPlayedFighterManager.getInstance().getMaxSummonedCreature());
        }

        [Untrusted]
        public static function getCurrentSummonedCreature():uint
        {
            return (CurrentPlayedFighterManager.getInstance().getCurrentSummonedCreature());
        }

        [Untrusted]
        public static function canSummon():Boolean
        {
            return (CurrentPlayedFighterManager.getInstance().canSummon());
        }

        [Untrusted]
        public static function getSpell(spellId:uint):SpellWrapper
        {
            return (CurrentPlayedFighterManager.getInstance().getSpellById(spellId));
        }

        [Untrusted]
        public static function canCastThisSpell(spellId:uint, lvl:uint):Boolean
        {
            return (CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId, lvl));
        }

        [Untrusted]
        public static function canCastThisSpellOnTarget(spellId:uint, lvl:uint, pTargetId:int):Boolean
        {
            return (CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId, lvl, pTargetId));
        }

        [Untrusted]
        public static function getSpellModification(spellId:uint, carac:int):int
        {
            var modif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(spellId, carac);
            if (((modif) && (modif.value)))
            {
                return ((((modif.value.alignGiftBonus + modif.value.base) + modif.value.contextModif) + modif.value.objectsAndMountBonus));
            };
            return (0);
        }

        [Untrusted]
        public static function isInHisHouse():Boolean
        {
            return (PlayedCharacterManager.getInstance().isInHisHouse);
        }

        [Untrusted]
        public static function getPlayerHouses():Vector.<AccountHouseInformations>
        {
            return ((Kernel.getWorker().getFrame(MiscFrame) as MiscFrame).accountHouses);
        }

        [Untrusted]
        public static function currentMap():WorldPointWrapper
        {
            return (PlayedCharacterManager.getInstance().currentMap);
        }

        [Untrusted]
        public static function currentSubArea():SubArea
        {
            return (PlayedCharacterManager.getInstance().currentSubArea);
        }

        [Untrusted]
        public static function state():uint
        {
            return (PlayedCharacterManager.getInstance().state);
        }

        [Untrusted]
        public static function isAlive():Boolean
        {
            return ((PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING));
        }

        [Untrusted]
        public static function getFollowingPlayerId():int
        {
            return (PlayedCharacterManager.getInstance().followingPlayerId);
        }

        [Untrusted]
        public static function getPlayerSet(objectGID:uint):PlayerSetInfo
        {
            return (PlayedCharacterUpdatesFrame(Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame)).getPlayerSet(objectGID));
        }

        [Untrusted]
        public static function getWeapon():WeaponWrapper
        {
            return (PlayedCharacterManager.getInstance().currentWeapon);
        }

        [Untrusted]
        public static function getExperienceBonusPercent():int
        {
            return (PlayedCharacterManager.getInstance().experiencePercent);
        }

        [Untrusted]
        public static function knowSpell(pSpellId:uint):int
        {
            var obtentionSpellLevel:uint;
            var playerSpellLevel:uint;
            var sp:SpellWrapper;
            var disable:Boolean;
            var spellWrapper:SpellWrapper;
            var _local_10:SpellLevel;
            var spell:Spell = Spell.getSpellById(pSpellId);
            var spellLevel:SpellLevel = SpellLevel.getLevelById(pSpellId);
            if (pSpellId == 0)
            {
                obtentionSpellLevel = 0;
            }
            else
            {
                _local_10 = spell.getSpellLevel(1);
                obtentionSpellLevel = _local_10.minPlayerLevel;
            };
            var spellInv:Array = getSpellInventory();
            for each (sp in spellInv)
            {
                if (sp.spellId == pSpellId)
                {
                    playerSpellLevel = sp.spellLevel;
                };
            };
            disable = true;
            for each (spellWrapper in spellInv)
            {
                if (spellWrapper.spellId == pSpellId)
                {
                    disable = false;
                };
            };
            if (disable)
            {
                return (-1);
            };
            return (playerSpellLevel);
        }


    }
}//package com.ankamagames.dofus.uiApi

