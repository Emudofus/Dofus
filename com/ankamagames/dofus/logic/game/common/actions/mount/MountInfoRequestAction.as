package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;

    public class MountInfoRequestAction implements Action 
    {

        public static const EFFECT_ID_MOUNT:int = 995;
        public static const EFFECT_ID_VALIDITY:int = 998;

        public var item:ItemWrapper;
        public var mountId:Number;
        public var time:Number;


        public static function create(item:ItemWrapper):MountInfoRequestAction
        {
            var effect:EffectInstance;
            var o:MountInfoRequestAction = new (MountInfoRequestAction)();
            o.item = item;
            for each (effect in item.effects)
            {
                switch (effect.effectId)
                {
                    case EFFECT_ID_MOUNT:
                        o.time = (effect as EffectInstanceMount).date;
                        o.mountId = (effect as EffectInstanceMount).mountId;
                        break;
                };
            };
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

