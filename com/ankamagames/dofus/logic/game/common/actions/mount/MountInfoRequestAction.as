package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
   
   public class MountInfoRequestAction extends Object implements Action
   {
      
      public function MountInfoRequestAction() {
         super();
      }
      
      public static const EFFECT_ID_MOUNT:int = 995;
      
      public static const EFFECT_ID_VALIDITY:int = 998;
      
      public static function create(item:ItemWrapper) : MountInfoRequestAction {
         var effect:EffectInstance = null;
         var o:MountInfoRequestAction = new MountInfoRequestAction();
         o.item = item;
         for each (effect in item.effects)
         {
            switch(effect.effectId)
            {
               case EFFECT_ID_MOUNT:
                  o.time = (effect as EffectInstanceMount).date;
                  o.mountId = (effect as EffectInstanceMount).mountId;
                  continue;
            }
         }
         return o;
      }
      
      public var item:ItemWrapper;
      
      public var mountId:Number;
      
      public var time:Number;
   }
}
