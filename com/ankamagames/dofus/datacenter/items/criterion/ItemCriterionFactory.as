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
      
      public static function create(param1:String) : ItemCriterion {
         var _loc2_:ItemCriterion = null;
         var _loc3_:String = param1.slice(0,2);
         switch(_loc3_)
         {
            case "BI":
               _loc2_ = new UnusableItemCriterion(param1);
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
               _loc2_ = new ItemCriterion(param1);
               break;
            case "OA":
               _loc2_ = new AchievementItemCriterion(param1);
               break;
            case "Ow":
               _loc2_ = new AllianceItemCriterion(param1);
               break;
            case "Ox":
               _loc2_ = new AllianceRightsItemCriterion(param1);
               break;
            case "Oz":
               _loc2_ = new AllianceAvAItemCriterion(param1);
               break;
            case "Pa":
               _loc2_ = new AlignmentLevelItemCriterion(param1);
               break;
            case "PA":
               _loc2_ = new SoulStoneItemCriterion(param1);
               break;
            case "Pb":
               _loc2_ = new FriendlistItemCriterion(param1);
               break;
            case "PB":
               _loc2_ = new SubareaItemCriterion(param1);
               break;
            case "Pe":
               _loc2_ = new PremiumAccountItemCriterion(param1);
               break;
            case "PE":
               _loc2_ = new EmoteItemCriterion(param1);
               break;
            case "Pf":
               _loc2_ = new RideItemCriterion(param1);
               break;
            case "Pg":
               _loc2_ = new GiftItemCriterion(param1);
               break;
            case "PG":
               _loc2_ = new BreedItemCriterion(param1);
               break;
            case "Pi":
            case "PI":
               _loc2_ = new SkillItemCriterion(param1);
               break;
            case "PJ":
            case "Pj":
               _loc2_ = new JobItemCriterion(param1);
               break;
            case "PK":
               _loc2_ = new KamaItemCriterion(param1);
               break;
            case "PL":
               _loc2_ = new LevelItemCriterion(param1);
               break;
            case "PN":
               _loc2_ = new NameItemCriterion(param1);
               break;
            case "PO":
               _loc2_ = new ObjectItemCriterion(param1);
               break;
            case "Po":
               _loc2_ = new AreaItemCriterion(param1);
               break;
            case "Pp":
            case "PP":
               _loc2_ = new PVPRankItemCriterion(param1);
               break;
            case "Pq":
               _loc2_ = new RankCriterion(param1);
               break;
            case "PQ":
               _loc2_ = new MaxRankCriterion(param1);
               break;
            case "Pr":
               _loc2_ = new SpecializationItemCriterion(param1);
               break;
            case "PR":
               _loc2_ = new MariedItemCriterion(param1);
               break;
            case "Ps":
               _loc2_ = new AlignmentItemCriterion(param1);
               break;
            case "PS":
               _loc2_ = new SexItemCriterion(param1);
               break;
            case "PT":
               _loc2_ = new SpellItemCriterion(param1);
               break;
            case "PU":
               _loc2_ = new BonesItemCriterion(param1);
               break;
            case "Pw":
               _loc2_ = new GuildItemCriterion(param1);
               break;
            case "PW":
               _loc2_ = new WeightItemCriterion(param1);
               break;
            case "Px":
               _loc2_ = new GuildRightsItemCriterion(param1);
               break;
            case "PX":
               _loc2_ = new AccountRightsItemCriterion(param1);
               break;
            case "Pz":
               break;
            case "Py":
               _loc2_ = new GuildLevelItemCriterion(param1);
               break;
            case "PZ":
               _loc2_ = new SubscribeItemCriterion(param1);
               break;
            case "Qa":
            case "Qc":
            case "Qf":
               _loc2_ = new QuestItemCriterion(param1);
               break;
            case "MK":
               _loc2_ = new MapCharactersItemCriterion(param1);
               break;
            case "Sc":
               _loc2_ = new StaticCriterionItemCriterion(param1);
               break;
            case "SG":
               _loc2_ = new MonthItemCriterion(param1);
               break;
            case "Sd":
               _loc2_ = new DayItemCriterion(param1);
               break;
            case "SI":
               _loc2_ = new ServerItemCriterion(param1);
               break;
            case "Sy":
               _loc2_ = new CommunityItemCriterion(param1);
               break;
            default:
               _log.warn("Criterion \'" + _loc3_ + "\' unknow or unused (" + param1 + ")");
         }
         return _loc2_;
      }
   }
}
