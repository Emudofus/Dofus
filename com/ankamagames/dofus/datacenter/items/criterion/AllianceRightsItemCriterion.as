package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.network.enums.AllianceRightsBitEnum;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AllianceRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function AllianceRightsItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc2_:* = false;
         if(!AllianceFrame.getInstance().hasAlliance)
         {
            if(_operator.text == ItemCriterionOperator.DIFFERENT)
            {
               return true;
            }
            return false;
         }
         var _loc1_:AllianceWrapper = AllianceFrame.getInstance().alliance;
         switch(criterionValue)
         {
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS:
               _loc2_ = _loc1_.isBoss;
               break;
            default:
               _loc2_ = true;
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return _loc2_;
            case ItemCriterionOperator.DIFFERENT:
               return !_loc2_;
            default:
               return false;
         }
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         var _loc2_:String = null;
         switch(criterionValue)
         {
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS:
               _loc2_ = I18n.getUiText("ui.guild.right.leader");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_KICK_GUILDS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsBann");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_MANAGE_PRISMS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsSetAlliancePrism");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_MANAGE_RIGHTS:
               _loc2_ = I18n.getUiText("ui.social.guildManageRights");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_RECRUIT_GUILDS:
               _loc2_ = I18n.getUiText("ui.social.guildRightsInvit");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_TALK_IN_CHAN:
               _loc2_ = I18n.getUiText("ui.social.guildRightsTalkInAllianceChannel");
               break;
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               _loc1_ = I18n.getUiText("ui.criterion.allianceRights",[_loc2_]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               _loc1_ = I18n.getUiText("ui.criterion.notAllianceRights",[_loc2_]);
               break;
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:AllianceRightsItemCriterion = new AllianceRightsItemCriterion(this.basicText);
         return _loc1_;
      }
   }
}
