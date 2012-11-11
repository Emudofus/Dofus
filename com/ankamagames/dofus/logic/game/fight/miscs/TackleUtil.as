package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class TackleUtil extends Object
    {

        public function TackleUtil()
        {
            return;
        }// end function

        public static function getTackle(param1:GameFightFighterInformations, param2:MapPoint) : Number
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_3:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if (Constants.DETERMINIST_TACKLE)
            {
                if (!canBeTackled(param1, param2))
                {
                    return 1;
                }
                _loc_4 = param2.x;
                _loc_5 = param2.y;
                _loc_6 = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
                _loc_7 = param1.stats.tackleEvade;
                if (_loc_7 < 0)
                {
                    _loc_7 = 0;
                }
                _loc_8 = new Array();
                if (MapPoint.isInMap((_loc_4 - 1), _loc_5))
                {
                    _loc_8.push(getTacklerOnCell(MapPoint.fromCoords((_loc_4 - 1), _loc_5).cellId));
                }
                if (MapPoint.isInMap((_loc_4 + 1), _loc_5))
                {
                    _loc_8.push(getTacklerOnCell(MapPoint.fromCoords((_loc_4 + 1), _loc_5).cellId));
                }
                if (MapPoint.isInMap(_loc_4, (_loc_5 - 1)))
                {
                    _loc_8.push(getTacklerOnCell(MapPoint.fromCoords(_loc_4, (_loc_5 - 1)).cellId));
                }
                if (MapPoint.isInMap(_loc_4, (_loc_5 + 1)))
                {
                    _loc_8.push(getTacklerOnCell(MapPoint.fromCoords(_loc_4, (_loc_5 + 1)).cellId));
                }
                _loc_9 = 1;
                for each (_loc_10 in _loc_8)
                {
                    
                    if (_loc_10)
                    {
                        _loc_11 = _loc_3.getEntityInfos(_loc_10.id) as GameFightFighterInformations;
                        if (canBeTackler(_loc_11, param1))
                        {
                            _loc_12 = _loc_11.stats.tackleBlock;
                            if (_loc_12 < 0)
                            {
                                _loc_12 = 0;
                            }
                            _loc_13 = (_loc_7 + 2) / (_loc_12 + 2) / 2;
                            if (_loc_13 < 1)
                            {
                                _loc_9 = _loc_9 * _loc_13;
                            }
                        }
                    }
                }
                return _loc_9;
            }
            else
            {
                return 1;
            }
        }// end function

        public static function getTackleForFighter(param1:GameFightFighterInformations, param2:GameFightFighterInformations) : Number
        {
            if (!Constants.DETERMINIST_TACKLE)
            {
                return 1;
            }
            if (!canBeTackled(param2))
            {
                return 1;
            }
            if (!canBeTackler(param1, param2))
            {
                return 1;
            }
            var _loc_3:* = param2.stats.tackleEvade;
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            var _loc_4:* = param1.stats.tackleBlock;
            if (param1.stats.tackleBlock < 0)
            {
                _loc_4 = 0;
            }
            return (_loc_3 + 2) / (_loc_4 + 2) / 2;
        }// end function

        public static function getTacklerOnCell(param1:int) : AnimatedCharacter
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_3:* = EntitiesManager.getInstance().getEntitiesOnCell(param1, AnimatedCharacter);
            for each (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_2.getEntityInfos(_loc_4.id) as GameFightFighterInformations;
                if (_loc_5.disposition is FightEntityDispositionInformations)
                {
                    if (!FightersStateManager.getInstance().hasState(_loc_4.id, 8))
                    {
                        return _loc_4;
                    }
                }
            }
            return null;
        }// end function

        public static function canBeTackled(param1:GameFightFighterInformations, param2:MapPoint = null) : Boolean
        {
            var _loc_3:* = null;
            if (FightersStateManager.getInstance().hasState(param1.contextualId, 96) || FightersStateManager.getInstance().hasState(param1.contextualId, 6) || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)
            {
                return false;
            }
            if (param1.disposition is FightEntityDispositionInformations)
            {
                _loc_3 = param1.disposition as FightEntityDispositionInformations;
                if (_loc_3.carryingCharacterId && (!param2 || param1.disposition.cellId == param2.cellId))
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function canBeTackler(param1:GameFightFighterInformations, param2:GameFightFighterInformations) : Boolean
        {
            var _loc_5:* = null;
            if (FightersStateManager.getInstance().hasState(param1.contextualId, 6) || FightersStateManager.getInstance().hasState(param1.contextualId, 95) || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)
            {
                return false;
            }
            var _loc_3:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            var _loc_4:* = _loc_3.getEntityInfos(param1.contextualId) as GameFightFighterInformations;
            if (_loc_3.getEntityInfos(param1.contextualId) as GameFightFighterInformations && _loc_4.teamId == param2.teamId)
            {
                return false;
            }
            if (param1 is GameFightMonsterInformations)
            {
                _loc_5 = Monster.getMonsterById((param1 as GameFightMonsterInformations).creatureGenericId);
                if (!_loc_5.canTackle)
                {
                    return false;
                }
            }
            return true;
        }// end function

    }
}
