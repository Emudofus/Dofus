package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   
   public class EffectsListWrapper extends Object implements IDataCenter
   {
      
      public function EffectsListWrapper(param1:Array) {
         var _loc2_:BasicBuff = null;
         var _loc3_:EffectInstance = null;
         var _loc4_:Effect = null;
         var _loc5_:* = 0;
         super();
         this._categories = new Array();
         for each (_loc2_ in param1)
         {
            _loc3_ = _loc2_.effects;
            _loc4_ = Effect.getEffectById(_loc3_.effectId);
            _loc5_ = _loc3_.trigger?CATEGORY_TRIGGERED:this.getCategory(_loc4_);
            this.addBuff(_loc5_,_loc2_);
         }
      }
      
      public static const CATEGORY_ACTIVE_BONUS:int = 0;
      
      public static const CATEGORY_ACTIVE_MALUS:int = 1;
      
      public static const CATEGORY_PASSIVE_BONUS:int = 2;
      
      public static const CATEGORY_PASSIVE_MALUS:int = 3;
      
      public static const CATEGORY_TRIGGERED:int = 4;
      
      public static const CATEGORY_STATE:int = 5;
      
      public static const CATEGORY_OTHER:int = 6;
      
      private var _categories:Array;
      
      public var effects:Vector.<EffectInstance>;
      
      public function get categories() : Array {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for (_loc2_ in this._categories)
         {
            if(this._categories[_loc2_].length > 0 && _loc1_[_loc2_] == null)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sort();
         return _loc1_;
      }
      
      public function getBuffs(param1:int) : Array {
         return this._categories[param1];
      }
      
      public function get buffArray() : Array {
         return this._categories;
      }
      
      private function addBuff(param1:int, param2:BasicBuff) : void {
         var _loc3_:BasicBuff = null;
         var _loc4_:Effect = null;
         if(!this._categories[param1])
         {
            this._categories[param1] = new Array();
         }
         for each (_loc3_ in this._categories[param1])
         {
            _loc4_ = Effect.getEffectById(param2.actionId);
            if((_loc4_.useDice) && _loc3_.actionId == param2.actionId && param2.trigger == false && !(param2 is StateBuff))
            {
               if(!(param2.effects is EffectInstanceInteger))
               {
                  throw new Error("Tentative de cumulation d\'effets ambigue");
               }
               else
               {
                  _loc3_.param1 = _loc3_.param1 + param2.param1;
                  _loc3_.param2 = _loc3_.param2 + param2.param2;
                  _loc3_.param3 = _loc3_.param3 + param2.param3;
                  return;
               }
            }
            else
            {
               continue;
            }
         }
         _loc3_ = param2.clone();
         this._categories[param1].push(_loc3_);
      }
      
      private function getCategory(param1:Effect) : int {
         if(param1.characteristic == 71)
         {
            return CATEGORY_STATE;
         }
         if(param1.operator == "-")
         {
            if(param1.active)
            {
               return CATEGORY_ACTIVE_MALUS;
            }
            return CATEGORY_PASSIVE_MALUS;
         }
         if(param1.operator == "+")
         {
            if(param1.active)
            {
               return CATEGORY_ACTIVE_BONUS;
            }
            return CATEGORY_PASSIVE_BONUS;
         }
         return CATEGORY_OTHER;
      }
   }
}
