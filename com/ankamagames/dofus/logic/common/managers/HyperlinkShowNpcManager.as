package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class HyperlinkShowNpcManager extends Object
    {

        public function HyperlinkShowNpcManager()
        {
            return;
        }// end function

        public static function showNpc(param1:int, param2:int = 0) : MovieClip
        {
            var _loc_4:Dictionary = null;
            var _loc_5:Object = null;
            var _loc_6:GraphicCell = null;
            var _loc_7:Rectangle = null;
            var _loc_3:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (_loc_3)
            {
                _loc_4 = _loc_3.getEntitiesDictionnary();
                for each (_loc_5 in _loc_4)
                {
                    
                    if (_loc_5 is GameRolePlayNpcInformations && (_loc_5.npcId == param1 || param1 == -1))
                    {
                        _loc_6 = InteractiveCellManager.getInstance().getCell(_loc_5.disposition.cellId);
                        _loc_7 = _loc_6.getRect(Berilia.getInstance().docMain);
                        return HyperlinkDisplayArrowManager.showAbsoluteArrow(_loc_7.x, _loc_7.y - 80, 0, 0, 1, param2);
                    }
                }
            }
            return null;
        }// end function

    }
}
