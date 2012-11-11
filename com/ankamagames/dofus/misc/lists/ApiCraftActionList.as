package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.logic.game.common.actions.jobs.*;
    import com.ankamagames.dofus.misc.utils.*;

    public class ApiCraftActionList extends Object
    {
        public static const JobCrafterDirectoryDefineSettings:DofusApiAction = new DofusApiAction("JobCrafterDirectoryDefineSettings", JobCrafterDirectoryDefineSettingsAction);
        public static const JobCrafterDirectoryEntryRequest:DofusApiAction = new DofusApiAction("JobCrafterDirectoryEntryRequest", JobCrafterDirectoryEntryRequestAction);
        public static const JobCrafterDirectoryListRequest:DofusApiAction = new DofusApiAction("JobCrafterDirectoryListRequest", JobCrafterDirectoryListRequestAction);
        public static const JobCrafterContactLookRequest:DofusApiAction = new DofusApiAction("JobCrafterContactLookRequest", JobCrafterContactLookRequestAction);

        public function ApiCraftActionList()
        {
            return;
        }// end function

    }
}
