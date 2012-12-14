package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class GuildRightsItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function GuildRightsItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_3:* = false;
            var _loc_1:* = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
            if (!_loc_1.hasGuild)
            {
                if (_operator.text == ItemCriterionOperator.DIFFERENT)
                {
                    return true;
                }
                return false;
            }
            var _loc_2:* = _loc_1.guild;
            switch(criterionValue)
            {
                case GuildRightsBitEnum.GUILD_RIGHT_BOSS:
                {
                    _loc_3 = _loc_2.isBoss;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_BAN_MEMBERS:
                {
                    _loc_3 = _loc_2.banMembers;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_COLLECT:
                {
                    _loc_3 = _loc_2.collect;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_COLLECT_MY_TAX_COLLECTOR:
                {
                    _loc_3 = _loc_2.collectMyTaxCollectors;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_DEFENSE_PRIORITY:
                {
                    _loc_3 = _loc_2.prioritizeMeInDefense;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_HIRE_TAX_COLLECTOR:
                {
                    _loc_3 = _loc_2.hireTaxCollector;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_INVITE_NEW_MEMBERS:
                {
                    _loc_3 = _loc_2.inviteNewMembers;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_GUILD_BOOSTS:
                {
                    _loc_3 = _loc_2.manageGuildBoosts;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_MY_XP_CONTRIBUTION:
                {
                    _loc_3 = _loc_2.manageMyXpContribution;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RANKS:
                {
                    _loc_3 = _loc_2.manageRanks;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RIGHTS:
                {
                    _loc_3 = _loc_2.manageRights;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_XP_CONTRIBUTION:
                {
                    _loc_3 = _loc_2.manageXPContribution;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_ORGANIZE_PADDOCKS:
                {
                    _loc_3 = _loc_2.organizeFarms;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_TAKE_OTHERS_MOUNTS_IN_PADDOCKS:
                {
                    _loc_3 = _loc_2.takeOthersRidesInFarm;
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_USE_PADDOCKS:
                {
                    _loc_3 = _loc_2.useFarms;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    return _loc_3;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    return !_loc_3;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            switch(criterionValue)
            {
                case GuildRightsBitEnum.GUILD_RIGHT_BOSS:
                {
                    _loc_2 = I18n.getUiText("ui.guild.right.leader");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_BAN_MEMBERS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsBann");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_COLLECT:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsCollect");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_COLLECT_MY_TAX_COLLECTOR:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsCollectMy");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_DEFENSE_PRIORITY:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsPrioritizeMe");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_HIRE_TAX_COLLECTOR:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsHiretax");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_INVITE_NEW_MEMBERS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsInvit");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_GUILD_BOOSTS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsBoost");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_MY_XP_CONTRIBUTION:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightManageOwnXP");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RANKS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsRank");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RIGHTS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildManageRights");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_XP_CONTRIBUTION:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsPercentXp");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_ORGANIZE_PADDOCKS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsMountParkArrange");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_TAKE_OTHERS_MOUNTS_IN_PADDOCKS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsManageOtherMount");
                    break;
                }
                case GuildRightsBitEnum.GUILD_RIGHT_USE_PADDOCKS:
                {
                    _loc_2 = I18n.getUiText("ui.social.guildRightsMountParkUse");
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_1 = I18n.getUiText("ui.criterion.guildRights", [_loc_2]);
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_1 = I18n.getUiText("ui.criterion.notGuildRights", [_loc_2]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new GuildRightsItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
