package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class QuestHookList extends Object
    {
        public static const QuestListUpdated:Hook = new Hook("QuestListUpdated", false);
        public static const QuestInfosUpdated:Hook = new Hook("QuestInfosUpdated", false);
        public static const QuestStarted:Hook = new Hook("QuestStarted", false);
        public static const QuestValidated:Hook = new Hook("QuestValidated", false);
        public static const QuestObjectiveValidated:Hook = new Hook("QuestObjectiveValidated", false);
        public static const QuestStepValidated:Hook = new Hook("QuestStepValidated", false);
        public static const QuestStepStarted:Hook = new Hook("QuestStepStarted", false);

        public function QuestHookList()
        {
            return;
        }// end function

    }
}
