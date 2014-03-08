package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.network.enums.GuildRightsBitEnum;
   import com.ankamagames.jerakine.data.I18n;
   
   public class GuildRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function GuildRightsItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc3_:* = false;
         var _loc1_:SocialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         if(!_loc1_.hasGuild)
         {
            if(_operator.text == ItemCriterionOperator.DIFFERENT)
            {
               return true;
            }
            return false;
         }
         var _loc2_:GuildWrapper = _loc1_.guild;
         switch(criterionValue)
         {
            case GuildRightsBitEnum.GUILD_RIGHT_BOSS:
               _loc3_ = _loc2_.isBoss;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_BAN_MEMBERS:
               _loc3_ = _loc2_.banMembers;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT:
               _loc3_ = _loc2_.collect;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT_MY_TAX_COLLECTOR:
               _loc3_ = _loc2_.collectMyTaxCollectors;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_DEFENSE_PRIORITY:
               _loc3_ = _loc2_.prioritizeMeInDefense;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_HIRE_TAX_COLLECTOR:
               _loc3_ = _loc2_.hireTaxCollector;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_INVITE_NEW_MEMBERS:
               _loc3_ = _loc2_.inviteNewMembers;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_GUILD_BOOSTS:
               _loc3_ = _loc2_.manageGuildBoosts;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_MY_XP_CONTRIBUTION:
               _loc3_ = _loc2_.manageMyXpContribution;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RANKS:
               _loc3_ = _loc2_.manageRanks;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RIGHTS:
               _loc3_ = _loc2_.manageRights;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_XP_CONTRIBUTION:
               _loc3_ = _loc2_.manageXPContribution;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_ORGANIZE_PADDOCKS:
               _loc3_ = _loc2_.organizeFarms;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_SET_ALLIANCE_PRISM:
               _loc3_ = _loc2_.setAlliancePrism;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TALK_IN_ALLIANCE_CHAN:
               _loc3_ = _loc2_.talkInAllianceChannel;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TAKE_OTHERS_MOUNTS_IN_PADDOCKS:
               _loc3_ = _loc2_.takeOthersRidesInFarm;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_USE_PADDOCKS:
               _loc3_ = _loc2_.useFarms;
               break;
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return _loc3_;
            case ItemCriterionOperator.DIFFERENT:
               return !_loc3_;
            default:
               return false;
         }
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         var _loc2_:String = null;
         switch(criterionValue)
         {
            case GuildRightsBitEnum.GUILD_RIGHT_BOSS:
               _loc2_ = I18n.getUiText("ui.guild.right.leader");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_BAN_MEMBERS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsBann");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT:
               _loc2_ = I18n.getUiText("ui.social.guildRightsCollect");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT_MY_TAX_COLLECTOR:
               _loc2_ = I18n.getUiText("ui.social.guildRightsCollectMy");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_DEFENSE_PRIORITY:
               _loc2_ = I18n.getUiText("ui.social.guildRightsPrioritizeMe");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_HIRE_TAX_COLLECTOR:
               _loc2_ = I18n.getUiText("ui.social.guildRightsHiretax");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_INVITE_NEW_MEMBERS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsInvit");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_GUILD_BOOSTS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsBoost");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_MY_XP_CONTRIBUTION:
               _loc2_ = I18n.getUiText("ui.social.guildRightManageOwnXP");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RANKS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsRank");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RIGHTS:
               _loc2_ = I18n.getUiText("ui.social.guildManageRights");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_XP_CONTRIBUTION:
               _loc2_ = I18n.getUiText("ui.social.guildRightsPercentXp");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_ORGANIZE_PADDOCKS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsMountParkArrange");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_SET_ALLIANCE_PRISM:
               _loc2_ = I18n.getUiText("ui.social.guildRightsSetAlliancePrism");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TALK_IN_ALLIANCE_CHAN:
               _loc2_ = I18n.getUiText("ui.social.guildRightsTalkInAllianceChannel");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TAKE_OTHERS_MOUNTS_IN_PADDOCKS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsManageOtherMount");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_USE_PADDOCKS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsMountParkUse");
               break;
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               _loc1_ = I18n.getUiText("ui.criterion.guildRights",[_loc2_]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               _loc1_ = I18n.getUiText("ui.criterion.notGuildRights",[_loc2_]);
               break;
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:GuildRightsItemCriterion = new GuildRightsItemCriterion(this.basicText);
         return _loc1_;
      }
   }
}
