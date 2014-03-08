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
      
      public static function create(param1:ItemWrapper) : MountInfoRequestAction {
         var _loc3_:EffectInstance = null;
         var _loc2_:MountInfoRequestAction = new MountInfoRequestAction();
         _loc2_.item = param1;
         for each (_loc3_ in param1.effects)
         {
            switch(_loc3_.effectId)
            {
               case EFFECT_ID_MOUNT:
                  _loc2_.time = (_loc3_ as EffectInstanceMount).date;
                  _loc2_.mountId = (_loc3_ as EffectInstanceMount).mountId;
                  continue;
               default:
                  continue;
            }
         }
         return _loc2_;
      }
      
      public var item:ItemWrapper;
      
      public var mountId:Number;
      
      public var time:Number;
   }
}
