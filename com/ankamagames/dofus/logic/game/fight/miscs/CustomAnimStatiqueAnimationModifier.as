package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class CustomAnimStatiqueAnimationModifier extends Object implements IAnimationModifier
    {
        public var randomStatique:Boolean;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomAnimStatiqueAnimationModifier));

        public function CustomAnimStatiqueAnimationModifier()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return AnimationModifierPriority.NORMAL;
        }// end function

        public function getModifiedAnimation(param1:String, param2:TiphonEntityLook) : String
        {
            var _loc_3:Swl = null;
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            switch(param1)
            {
                case AnimationEnum.ANIM_STATIQUE:
                {
                    if (param2.getBone() == 1)
                    {
                        if (this.randomStatique)
                        {
                            _loc_3 = Tiphon.skullLibrary.getResourceById(param2.getBone(), AnimationEnum.ANIM_STATIQUE);
                            _loc_4 = new Array();
                            if (_loc_3)
                            {
                                for each (_loc_5 in _loc_3.getDefinitions())
                                {
                                    
                                    if (_loc_5.indexOf(AnimationEnum.ANIM_STATIQUE + param2.skins[0].toString()) == 0)
                                    {
                                        _loc_6 = _loc_5.split("_")[0];
                                        if (_loc_4.indexOf(_loc_6) == -1)
                                        {
                                            _loc_4.push(_loc_6);
                                        }
                                    }
                                }
                            }
                            else
                            {
                                _loc_4.push(AnimationEnum.ANIM_STATIQUE + param2.skins[0].toString());
                            }
                            if (_loc_4.length > 1)
                            {
                                _loc_7 = Math.floor(Math.random() * _loc_4.length);
                                return _loc_4[_loc_7];
                            }
                            return _loc_4[0];
                        }
                        else
                        {
                            _loc_8 = param2.skins[0];
                            if (_loc_8 == 1114 || _loc_8 == 1115 || _loc_8 == 1402 || _loc_8 == 1463)
                            {
                                return AnimationEnum.ANIM_STATIQUE;
                            }
                            return AnimationEnum.ANIM_STATIQUE + param2.skins[0].toString();
                        }
                    }
                    else
                    {
                        return param1;
                    }
                }
                default:
                {
                    return param1;
                    break;
                }
            }
        }// end function

    }
}
