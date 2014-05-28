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
      
      public static const JobCrafterDirectoryDefineSettings:DofusApiAction;
      
      public static const JobCrafterDirectoryEntryRequest:DofusApiAction;
      
      public static const JobCrafterDirectoryListRequest:DofusApiAction;
      
      public static const JobCrafterContactLookRequest:DofusApiAction;
      
      public static const ExchangeSetCraftRecipe:DofusApiAction;
   }
}
