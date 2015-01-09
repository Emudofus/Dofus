package com.ankamagames.dofus.logic.common.managers
{
    import flash.utils.Dictionary;
    import com.ankamagames.atouin.types.GraphicCell;
    import flash.geom.Rectangle;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.berilia.Berilia;
    import flash.display.MovieClip;

    public class HyperlinkShowNpcManager 
    {


        public static function showNpc(npcId:int, loop:int=0):MovieClip
        {
            var list:Dictionary;
            var npc:Object;
            var graphicCell:GraphicCell;
            var rect:Rectangle;
            var abstractEntitiesFrame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (abstractEntitiesFrame)
            {
                list = abstractEntitiesFrame.getEntitiesDictionnary();
                for each (npc in list)
                {
                    if ((((npc is GameRolePlayNpcInformations)) && ((((npc.npcId == npcId)) || ((npcId == -1))))))
                    {
                        graphicCell = InteractiveCellManager.getInstance().getCell(npc.disposition.cellId);
                        rect = graphicCell.getRect(Berilia.getInstance().docMain);
                        rect.y = (rect.y - 80);
                        return (HyperlinkDisplayArrowManager.showAbsoluteArrow(rect, 0, 0, 1, loop));
                    };
                };
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.logic.common.managers

