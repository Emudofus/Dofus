package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountInfoRequestAction extends Object implements Action
    {
        public var item:ItemWrapper;
        public var mountId:Number;
        public var time:Number;
        public static const EFFECT_ID_MOUNT:int = 995;
        public static const EFFECT_ID_VALIDITY:int = 998;

        public function MountInfoRequestAction()
        {
            return;
        }// end function

        public static function create(param1:ItemWrapper) : MountInfoRequestAction
        {
            var _loc_3:* = null;
            var _loc_2:* = new MountInfoRequestAction;
            _loc_2.item = param1;
            for each (_loc_3 in param1.effects)
            {
                
                switch(_loc_3.effectId)
                {
                    case EFFECT_ID_MOUNT:
                    {
                        _loc_2.time = (_loc_3 as EffectInstanceMount).date;
                        _loc_2.mountId = (_loc_3 as EffectInstanceMount).mountId;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_2;
        }// end function

    }
}
