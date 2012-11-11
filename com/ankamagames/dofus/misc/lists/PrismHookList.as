package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class PrismHookList extends Object
    {
        public static const PrismBalance:Hook = new Hook("PrismBalance", false);
        public static const PrismWorldInformation:Hook = new Hook("PrismWorldInformation", false);
        public static const PrismAlignmentBonus:Hook = new Hook("PrismAlignmentBonus", false);
        public static const PrismAdd:Hook = new Hook("PrismAdd", false);
        public static const PrismRemoved:Hook = new Hook("PrismRemoved", false);
        public static const PrismFightUpdate:Hook = new Hook("PrismFightUpdate", false);
        public static const PrismAttacked:Hook = new Hook("PrismAttacked", false);
        public static const PrismInfoClose:Hook = new Hook("PrismInfoClose", false);
        public static const PrismInfoValid:Hook = new Hook("PrismInfoValid", false);
        public static const PrismInfoInvalid:Hook = new Hook("PrismInfoInvalid", false);
        public static const PrismFightStateUpdate:Hook = new Hook("PrismFightStateUpdate", false);

        public function PrismHookList()
        {
            return;
        }// end function

    }
}
