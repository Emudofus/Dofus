package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ItemCriterionFactory extends Object implements IDataCenter
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemCriterionFactory));

        public function ItemCriterionFactory()
        {
            return;
        }// end function

        public static function create(param1:String) : ItemCriterion
        {
            var _loc_2:* = null;
            var _loc_3:* = param1.slice(0, 2);
            switch(_loc_3)
            {
                case "BI":
                {
                    _loc_2 = new UnusableItemCriterion(param1);
                    break;
                }
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
                {
                    _loc_2 = new ItemCriterion(param1);
                    break;
                }
                case "Pa":
                {
                    _loc_2 = new AlignmentLevelItemCriterion(param1);
                    break;
                }
                case "PA":
                {
                    _loc_2 = new SoulStoneItemCriterion(param1);
                    break;
                }
                case "Pb":
                {
                    _loc_2 = new FriendlistItemCriterion(param1);
                    break;
                }
                case "PB":
                {
                    _loc_2 = new SubareaItemCriterion(param1);
                    break;
                }
                case "Pe":
                {
                    _loc_2 = new PremiumAccountItemCriterion(param1);
                    break;
                }
                case "PE":
                {
                    _loc_2 = new EmoteItemCriterion(param1);
                    break;
                }
                case "Pf":
                {
                    _loc_2 = new RideItemCriterion(param1);
                    break;
                }
                case "Pg":
                {
                    _loc_2 = new GiftItemCriterion(param1);
                    break;
                }
                case "PG":
                {
                    _loc_2 = new BreedItemCriterion(param1);
                    break;
                }
                case "Pi":
                case "PI":
                {
                    _loc_2 = new SkillItemCriterion(param1);
                    break;
                }
                case "PJ":
                case "Pj":
                {
                    _loc_2 = new JobItemCriterion(param1);
                    break;
                }
                case "PK":
                {
                    _loc_2 = new KamaItemCriterion(param1);
                    break;
                }
                case "PL":
                {
                    _loc_2 = new LevelItemCriterion(param1);
                    break;
                }
                case "PN":
                {
                    _loc_2 = new NameItemCriterion(param1);
                    break;
                }
                case "PO":
                {
                    _loc_2 = new ObjectItemCriterion(param1);
                    break;
                }
                case "Pp":
                case "PP":
                {
                    _loc_2 = new PVPRankItemCriterion(param1);
                    break;
                }
                case "Pr":
                {
                    _loc_2 = new SpecializationItemCriterion(param1);
                    break;
                }
                case "PR":
                {
                    _loc_2 = new MariedItemCriterion(param1);
                    break;
                }
                case "Ps":
                {
                    _loc_2 = new AlignmentItemCriterion(param1);
                    break;
                }
                case "PS":
                {
                    _loc_2 = new SexItemCriterion(param1);
                    break;
                }
                case "PT":
                {
                    _loc_2 = new SpellItemCriterion(param1);
                    break;
                }
                case "PU":
                {
                    _loc_2 = new BonesItemCriterion(param1);
                    break;
                }
                case "Pw":
                {
                    _loc_2 = new GuildItemCriterion(param1);
                    break;
                }
                case "PW":
                {
                    _loc_2 = new WeightItemCriterion(param1);
                    break;
                }
                case "Px":
                {
                    _loc_2 = new GuildRightsItemCriterion(param1);
                    break;
                }
                case "PX":
                {
                    _loc_2 = new AccountRightsItemCriterion(param1);
                    break;
                }
                case "Pz":
                {
                    break;
                }
                case "Py":
                {
                    _loc_2 = new GuildLevelItemCriterion(param1);
                    break;
                }
                case "PZ":
                {
                    _loc_2 = new SubscribeItemCriterion(param1);
                    break;
                }
                case "Qa":
                case "Qc":
                case "Qf":
                {
                    _loc_2 = new QuestItemCriterion(param1);
                    break;
                }
                case "MK":
                {
                    _loc_2 = new MapCharactersItemCriterion(param1);
                    break;
                }
                case "Sc":
                {
                    _loc_2 = new StaticCriterionItemCriterion(param1);
                    break;
                }
                case "SG":
                {
                    _loc_2 = new MonthItemCriterion(param1);
                    break;
                }
                case "Sd":
                {
                    _loc_2 = new DayItemCriterion(param1);
                    break;
                }
                case "SI":
                {
                    _loc_2 = new ServerItemCriterion(param1);
                    break;
                }
                case "Pq":
                {
                    _loc_2 = new RankCriterion(param1);
                    break;
                }
                case "PQ":
                {
                    _loc_2 = new MaxRankCriterion(param1);
                    break;
                }
                default:
                {
                    _log.warn("Criterion \'" + _loc_3 + "\' unknow or unused (" + param1 + ")");
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
