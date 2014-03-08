package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ItemCriterionFactory extends Object implements IDataCenter
   {
      
      public function ItemCriterionFactory() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemCriterionFactory));
      
      public static function create(pServerCriterionForm:String) : ItemCriterion {
         var criterion:ItemCriterion = null;
         var s:String = pServerCriterionForm.slice(0,2);
         switch(s)
         {
            case "BI":
               criterion = new UnusableItemCriterion(pServerCriterionForm);
               break;
            case "Ca":
            case "CA":
            case "Cc":
            case "CC":
            case "Ce":
            case "CE":
            case "CD":
            case "CH":
            case "Ci":
            case "CI":
            case "CL":
            case "CM":
            case "CP":
            case "Cs":
            case "CS":
            case "Cv":
            case "CV":
            case "Cw":
            case "CW":
            case "Ct":
            case "CT":
               criterion = new ItemCriterion(pServerCriterionForm);
               break;
            case "OA":
               criterion = new AchievementItemCriterion(pServerCriterionForm);
               break;
            case "Ow":
               criterion = new AllianceItemCriterion(pServerCriterionForm);
               break;
            case "Ox":
               criterion = new AllianceRightsItemCriterion(pServerCriterionForm);
               break;
            case "Oz":
               criterion = new AllianceAvAItemCriterion(pServerCriterionForm);
               break;
            case "Pa":
               criterion = new AlignmentLevelItemCriterion(pServerCriterionForm);
               break;
            case "PA":
               criterion = new SoulStoneItemCriterion(pServerCriterionForm);
               break;
            case "Pb":
               criterion = new FriendlistItemCriterion(pServerCriterionForm);
               break;
            case "PB":
               criterion = new SubareaItemCriterion(pServerCriterionForm);
               break;
            case "Pe":
               criterion = new PremiumAccountItemCriterion(pServerCriterionForm);
               break;
            case "PE":
               criterion = new EmoteItemCriterion(pServerCriterionForm);
               break;
            case "Pf":
               criterion = new RideItemCriterion(pServerCriterionForm);
               break;
            case "Pg":
               criterion = new GiftItemCriterion(pServerCriterionForm);
               break;
            case "PG":
               criterion = new BreedItemCriterion(pServerCriterionForm);
               break;
            case "Pi":
            case "PI":
               criterion = new SkillItemCriterion(pServerCriterionForm);
               break;
            case "PJ":
            case "Pj":
               criterion = new JobItemCriterion(pServerCriterionForm);
               break;
            case "PK":
               criterion = new KamaItemCriterion(pServerCriterionForm);
               break;
            case "PL":
               criterion = new LevelItemCriterion(pServerCriterionForm);
               break;
            case "PN":
               criterion = new NameItemCriterion(pServerCriterionForm);
               break;
            case "PO":
               criterion = new ObjectItemCriterion(pServerCriterionForm);
               break;
            case "Po":
               criterion = new AreaItemCriterion(pServerCriterionForm);
               break;
            case "Pp":
            case "PP":
               criterion = new PVPRankItemCriterion(pServerCriterionForm);
               break;
            case "Pq":
               criterion = new RankCriterion(pServerCriterionForm);
               break;
            case "PQ":
               criterion = new MaxRankCriterion(pServerCriterionForm);
               break;
            case "Pr":
               criterion = new SpecializationItemCriterion(pServerCriterionForm);
               break;
            case "PR":
               criterion = new MariedItemCriterion(pServerCriterionForm);
               break;
            case "Ps":
               criterion = new AlignmentItemCriterion(pServerCriterionForm);
               break;
            case "PS":
               criterion = new SexItemCriterion(pServerCriterionForm);
               break;
            case "PT":
               criterion = new SpellItemCriterion(pServerCriterionForm);
               break;
            case "PU":
               criterion = new BonesItemCriterion(pServerCriterionForm);
               break;
            case "Pw":
               criterion = new GuildItemCriterion(pServerCriterionForm);
               break;
            case "PW":
               criterion = new WeightItemCriterion(pServerCriterionForm);
               break;
            case "Px":
               criterion = new GuildRightsItemCriterion(pServerCriterionForm);
               break;
            case "PX":
               criterion = new AccountRightsItemCriterion(pServerCriterionForm);
               break;
            case "Pz":
               break;
            case "Py":
               criterion = new GuildLevelItemCriterion(pServerCriterionForm);
               break;
            case "PZ":
               criterion = new SubscribeItemCriterion(pServerCriterionForm);
               break;
            case "Qa":
            case "Qc":
            case "Qf":
               criterion = new QuestItemCriterion(pServerCriterionForm);
               break;
            case "MK":
               criterion = new MapCharactersItemCriterion(pServerCriterionForm);
               break;
            case "Sc":
               criterion = new StaticCriterionItemCriterion(pServerCriterionForm);
               break;
            case "SG":
               criterion = new MonthItemCriterion(pServerCriterionForm);
               break;
            case "Sd":
               criterion = new DayItemCriterion(pServerCriterionForm);
               break;
            case "SI":
               criterion = new ServerItemCriterion(pServerCriterionForm);
               break;
            case "Sy":
               criterion = new CommunityItemCriterion(pServerCriterionForm);
               break;
         }
         return criterion;
      }
   }
}
