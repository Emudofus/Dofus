package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class HyperlinkShowOfflineSales 
    {


        public static function showOfflineSales():void
        {
            var chatFrame:ChatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
            KernelEventsManager.getInstance().processCallback(HookList.OpenOfflineSales, chatFrame.offlineSales);
        }


    }
}//package com.ankamagames.dofus.logic.common.managers

