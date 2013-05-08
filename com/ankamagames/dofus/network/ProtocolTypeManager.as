package com.ankamagames.dofus.network
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberArenaInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterHardcoreInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMinimalStats;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMinimalStatsPreparation;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultMutantListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultAdditionalData;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPvpData;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultExperienceData;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostStateEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostWeaponDamagesEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellImmunityEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTriggeredEffect;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectCreature;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectLadder;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDuration;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMinMax;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectString;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMount;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDate;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountBoost;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountIntBoost;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObject;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectItem;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectPreset;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutSpell;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutEmote;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutSmiley;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseOnlineInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementNamedSkill;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementWithAgeBonus;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescription;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionTimed;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionCollect;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionCraft;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsExtended;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockBuyableInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockAbandonnedInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockPrivateInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightAIInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterWithAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantWithGuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMountInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcWithQuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOption;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionOrnament;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionFollowers;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionGuild;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionEmote;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformationsInWaitForHelpState;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformationsWithAlternatives;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveDetailedInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformationsWithCompletion;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;


   public class ProtocolTypeManager extends Object
   {
         

      public function ProtocolTypeManager() {
         super();
      }

      private static const _typesTypes:Dictionary = new Dictionary();

      public static function getInstance(base:Class, typeId:uint) : * {
         var objType:Class = _typesTypes[typeId];
         if(!objType)
         {
            throw new Error("Type with id "+typeId+" is unknown.");
         }
         else
         {
            obj=new objType();
            if(!(obj is base))
            {
               throw new Error("Type "+typeId+" is not a "+base+".");
            }
            else
            {
               return obj;
            }
         }
      }

      public static function register() : void {
         StoreDataManager.getInstance().registerClass(new CharacterBaseInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PartyMemberInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PartyMemberArenaInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new CharacterHardcoreInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PartyInvitationMemberInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new EntityDispositionInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new IdentifiedEntityDispositionInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FightEntityDispositionInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTeamMemberInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTeamMemberCharacterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTeamMemberMonsterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTeamMemberTaxCollectorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMinimalStats(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMinimalStatsPreparation(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultListEntry(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultFighterListEntry(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultMutantListEntry(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultPlayerListEntry(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultTaxCollectorListEntry(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultAdditionalData(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultPvpData(),true,true);
         StoreDataManager.getInstance().registerClass(new FightResultExperienceData(),true,true);
         StoreDataManager.getInstance().registerClass(new AbstractFightDispellableEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTemporaryBoostEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTemporaryBoostStateEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTemporaryBoostWeaponDamagesEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTemporarySpellBoostEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTemporarySpellImmunityEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new FightTriggeredEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffect(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectInteger(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectCreature(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectLadder(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectDuration(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectDice(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectMinMax(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectString(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectMount(),true,true);
         StoreDataManager.getInstance().registerClass(new ObjectEffectDate(),true,true);
         StoreDataManager.getInstance().registerClass(new UpdateMountBoost(),true,true);
         StoreDataManager.getInstance().registerClass(new UpdateMountIntBoost(),true,true);
         StoreDataManager.getInstance().registerClass(new Shortcut(),true,true);
         StoreDataManager.getInstance().registerClass(new ShortcutObject(),true,true);
         StoreDataManager.getInstance().registerClass(new ShortcutObjectItem(),true,true);
         StoreDataManager.getInstance().registerClass(new ShortcutObjectPreset(),true,true);
         StoreDataManager.getInstance().registerClass(new ShortcutSpell(),true,true);
         StoreDataManager.getInstance().registerClass(new ShortcutEmote(),true,true);
         StoreDataManager.getInstance().registerClass(new ShortcutSmiley(),true,true);
         StoreDataManager.getInstance().registerClass(new IgnoredInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new IgnoredOnlineInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FriendInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FriendOnlineInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FriendSpouseInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new FriendSpouseOnlineInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new InteractiveElementSkill(),true,true);
         StoreDataManager.getInstance().registerClass(new InteractiveElementNamedSkill(),true,true);
         StoreDataManager.getInstance().registerClass(new InteractiveElement(),true,true);
         StoreDataManager.getInstance().registerClass(new InteractiveElementWithAgeBonus(),true,true);
         StoreDataManager.getInstance().registerClass(new PartyMemberInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PartyMemberArenaInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new SkillActionDescription(),true,true);
         StoreDataManager.getInstance().registerClass(new SkillActionDescriptionTimed(),true,true);
         StoreDataManager.getInstance().registerClass(new SkillActionDescriptionCollect(),true,true);
         StoreDataManager.getInstance().registerClass(new SkillActionDescriptionCraft(),true,true);
         StoreDataManager.getInstance().registerClass(new HouseInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new HouseInformationsExtended(),true,true);
         StoreDataManager.getInstance().registerClass(new PaddockInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PaddockBuyableInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PaddockAbandonnedInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PaddockPrivateInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PaddockContentInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameContextActorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightFighterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightAIInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMonsterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMonsterWithAlignmentInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightTaxCollectorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightFighterNamedInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMutantInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightCharacterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayActorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayNamedActorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMerchantInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMerchantWithGuildInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayHumanoidInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMutantInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayCharacterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMountInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayNpcInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayNpcWithQuestInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayGroupMonsterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayTaxCollectorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayPrismInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayActorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayNamedActorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMerchantInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMerchantWithGuildInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayHumanoidInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMutantInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayCharacterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayMountInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayNpcInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayNpcWithQuestInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayGroupMonsterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayTaxCollectorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameRolePlayPrismInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanOption(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanOptionOrnament(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanOptionFollowers(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanOptionGuild(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanOptionTitle(),true,true);
         StoreDataManager.getInstance().registerClass(new HumanOptionEmote(),true,true);
         StoreDataManager.getInstance().registerClass(new TaxCollectorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new TaxCollectorInformationsInWaitForHelpState(),true,true);
         StoreDataManager.getInstance().registerClass(new GroupMonsterStaticInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GroupMonsterStaticInformationsWithAlternatives(),true,true);
         StoreDataManager.getInstance().registerClass(new QuestActiveInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new QuestActiveDetailedInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new QuestObjectiveInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new QuestObjectiveInformationsWithCompletion(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightFighterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightAIInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMonsterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMonsterWithAlignmentInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightTaxCollectorInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightFighterNamedInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightMutantInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new GameFightCharacterInformations(),true,true);
         StoreDataManager.getInstance().registerClass(new PlayerStatus(),true,true);
         StoreDataManager.getInstance().registerClass(new PlayerStatusExtended(),true,true);
      }


   }

}