package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class HyperlinkShowMonsterManager extends Object
    {

        public function HyperlinkShowMonsterManager()
        {
            return;
        }// end function

        public static function showMonster(param1:int, param2:int = 0) : Sprite
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (_loc_3)
            {
                _loc_6 = _loc_3.getEntitiesDictionnary();
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_7 is GameRolePlayGroupMonsterInformations && (_loc_7.staticInfos.mainCreatureLightInfos.creatureGenericId == param1 || param1 == -1))
                    {
                        _loc_4 = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(_loc_7).contextualId) as DisplayObject;
                        if (_loc_4 && _loc_4.stage)
                        {
                            return HyperlinkDisplayArrowManager.showAbsoluteArrow(_loc_4.x, _loc_4.y - 80, 0, 0, 1, param2);
                        }
                        return null;
                        continue;
                    }
                    if (_loc_7 is GameFightMonsterInformations && (_loc_7.creatureGenericId == param1 || param1 == -1))
                    {
                        _loc_4 = DofusEntities.getEntity(GameFightMonsterInformations(_loc_7).contextualId) as DisplayObject;
                        if (_loc_4 && _loc_4.stage)
                        {
                            _loc_5 = _loc_4.getRect(Berilia.getInstance().docMain);
                            return HyperlinkDisplayArrowManager.showAbsoluteArrow(_loc_5.x, _loc_5.y, 0, 0, 1, param2);
                        }
                        return null;
                    }
                }
            }
            return null;
        }// end function

        public static function getMonsterName(param1:uint) : String
        {
            var _loc_2:* = Monster.getMonsterById(param1);
            if (_loc_2)
            {
                return _loc_2.name;
            }
            return "[null]";
        }// end function

    }
}
