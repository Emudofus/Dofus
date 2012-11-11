package com.ankamagames.dofus.factories
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class RolePlayEntitiesFactory extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RolePlayEntitiesFactory));
        private static const TEAM_CHALLENGER_LOOK:String = "{19}";
        private static const TEAM_DEFENDER_LOOK:String = "{20}";
        private static const TEAM_TAX_COLLECTOR_LOOK:String = "{21}";
        private static const TEAM_ANGEL_LOOK:String = "{32}";
        private static const TEAM_DEMON_LOOK:String = "{33}";
        private static const TEAM_NEUTRAL_LOOK:String = "{1237}";
        private static const TEAM_BAD_ANGEL_LOOK:String = "{1235}";
        private static const TEAM_BAD_DEMON_LOOK:String = "{1236}";

        public function RolePlayEntitiesFactory()
        {
            return;
        }// end function

        public static function createFightEntity(param1:FightCommonInformations, param2:FightTeamInformations, param3:MapPoint) : IEntity
        {
            var _loc_5:* = null;
            var _loc_4:* = EntitiesManager.getInstance().getFreeEntityId();
            switch(param1.fightType)
            {
                case FightTypeEnum.FIGHT_TYPE_AGRESSION:
                case FightTypeEnum.FIGHT_TYPE_PvMA:
                {
                    switch(param2.teamSide)
                    {
                        case AlignmentSideEnum.ALIGNMENT_ANGEL:
                        {
                            if (param2.teamTypeId == TeamTypeEnum.TEAM_TYPE_BAD_PLAYER)
                            {
                                _loc_5 = TEAM_BAD_ANGEL_LOOK;
                            }
                            else
                            {
                                _loc_5 = TEAM_ANGEL_LOOK;
                            }
                            break;
                        }
                        case AlignmentSideEnum.ALIGNMENT_EVIL:
                        {
                            if (param2.teamTypeId == TeamTypeEnum.TEAM_TYPE_BAD_PLAYER)
                            {
                                _loc_5 = TEAM_BAD_DEMON_LOOK;
                            }
                            else
                            {
                                _loc_5 = TEAM_DEMON_LOOK;
                            }
                            break;
                        }
                        case AlignmentSideEnum.ALIGNMENT_NEUTRAL:
                        case AlignmentSideEnum.ALIGNMENT_MERCENARY:
                        {
                            _loc_5 = TEAM_NEUTRAL_LOOK;
                            break;
                        }
                        case AlignmentSideEnum.ALIGNMENT_WITHOUT:
                        {
                            _loc_5 = TEAM_CHALLENGER_LOOK;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case FightTypeEnum.FIGHT_TYPE_PvT:
                {
                    switch(param2.teamId)
                    {
                        case TeamEnum.TEAM_DEFENDER:
                        {
                            _loc_5 = TEAM_TAX_COLLECTOR_LOOK;
                            break;
                        }
                        case TeamEnum.TEAM_CHALLENGER:
                        {
                            _loc_5 = TEAM_CHALLENGER_LOOK;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case FightTypeEnum.FIGHT_TYPE_CHALLENGE:
                {
                    _loc_5 = TEAM_CHALLENGER_LOOK;
                    break;
                }
                default:
                {
                    switch(param2.teamId)
                    {
                        case TeamEnum.TEAM_CHALLENGER:
                        {
                            _loc_5 = TEAM_CHALLENGER_LOOK;
                            break;
                        }
                        case TeamEnum.TEAM_DEFENDER:
                        {
                            _loc_5 = TEAM_DEFENDER_LOOK;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                    break;
                }
            }
            var _loc_6:* = new AnimatedCharacter(_loc_4, TiphonEntityLook.fromString(_loc_5));
            new AnimatedCharacter(_loc_4, TiphonEntityLook.fromString(_loc_5)).position = param3;
            IAnimated(_loc_6).setDirection(0);
            return _loc_6;
        }// end function

    }
}
