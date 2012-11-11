package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class CraftHookList extends Object
    {
        public static const DoNothing:Hook = new Hook("DoNothing", false);
        public static const ExchangeStartOkMultiCraft:Hook = new Hook("ExchangeStartOkMultiCraft", false);
        public static const ExchangeStartOkCraft:Hook = new Hook("ExchangeStartOkCraft", false);
        public static const ExchangeCraftResult:Hook = new Hook("ExchangeCraftResult", false);
        public static const PlayerListUpdate:Hook = new Hook("PlayerListUpdate", false);
        public static const OtherPlayerListUpdate:Hook = new Hook("OtherPlayerListUpdate", false);
        public static const PaymentCraftList:Hook = new Hook("PaymentCraftList", false);
        public static const BagListUpdate:Hook = new Hook("BagListUpdate", false);
        public static const ExchangeItemAutoCraftStoped:Hook = new Hook("ExchangeItemAutoCraftStoped", false);
        public static const ExchangeMultiCraftCrafterCanUseHisRessources:Hook = new Hook("ExchangeMultiCraftCrafterCanUseHisRessources", false);
        public static const ExchangeMultiCraftRequest:Hook = new Hook("ExchangeMultiCraftRequest", false);
        public static const ExchangeReplayCountModified:Hook = new Hook("ExchangeReplayCountModified", false);
        public static const ExchangeItemAutoCraftRemaining:Hook = new Hook("ExchangeItemAutoCraftRemaining", false);
        public static const RecipeSelected:Hook = new Hook("RecipeSelected", false);
        public static const JobLevelUp:Hook = new Hook("JobLevelUp", false);
        public static const JobsExpUpdated:Hook = new Hook("JobsExpUpdated", false);
        public static const ExchangeStartOkJobIndex:Hook = new Hook("ExchangeStartOkJobIndex", false);
        public static const CrafterDirectoryListUpdate:Hook = new Hook("CrafterDirectoryListUpdate", false);
        public static const CrafterDirectorySettings:Hook = new Hook("CrafterDirectorySettings", false);
        public static const JobCrafterContactLook:Hook = new Hook("JobCrafterContactLook", false);
        public static const JobAllowMultiCraftRequest:Hook = new Hook("JobAllowMultiCraftRequest", false);
        public static const ExchangeCraftSlotCountIncreased:Hook = new Hook("ExchangeCraftSlotCountIncreased", false);

        public function CraftHookList()
        {
            return;
        }// end function

    }
}
