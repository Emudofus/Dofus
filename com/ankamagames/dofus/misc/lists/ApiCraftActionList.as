package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryDefineSettingsAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryEntryRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeSetCraftRecipeAction;
   
   public class ApiCraftActionList extends Object
   {
      
      public function ApiCraftActionList() {
         super();
      }
      
      public static const JobCrafterDirectoryDefineSettings:DofusApiAction = new DofusApiAction("JobCrafterDirectoryDefineSettings",JobCrafterDirectoryDefineSettingsAction);
      
      public static const JobCrafterDirectoryEntryRequest:DofusApiAction = new DofusApiAction("JobCrafterDirectoryEntryRequest",JobCrafterDirectoryEntryRequestAction);
      
      public static const JobCrafterDirectoryListRequest:DofusApiAction = new DofusApiAction("JobCrafterDirectoryListRequest",JobCrafterDirectoryListRequestAction);
      
      public static const JobCrafterContactLookRequest:DofusApiAction = new DofusApiAction("JobCrafterContactLookRequest",JobCrafterContactLookRequestAction);
      
      public static const ExchangeSetCraftRecipe:DofusApiAction = new DofusApiAction("ExchangeSetCraftRecipe",ExchangeSetCraftRecipeAction);
   }
}
