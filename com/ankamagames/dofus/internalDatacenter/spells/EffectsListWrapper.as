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
      
      public function EffectsListWrapper(buffs:Array) {
         var buff:BasicBuff = null;
         var effect:EffectInstance = null;
         var effectData:Effect = null;
         var category:* = 0;
         super();
         this._categories = new Array();
         for each (buff in buffs)
         {
            effect = buff.effects;
            effectData = Effect.getEffectById(effect.effectId);
            category = effect.trigger?CATEGORY_TRIGGERED:this.getCategory(effectData);
            this.addBuff(category,buff);
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
         var c:String = null;
         var cat:Array = new Array();
         for (c in this._categories)
         {
            if((this._categories[c].length > 0) && (cat[c] == null))
            {
               cat.push(c);
            }
         }
         cat.sort();
         return cat;
      }
      
      public function getBuffs(category:int) : Array {
         return this._categories[category];
      }
      
      public function get buffArray() : Array {
         return this._categories;
      }
      
      private function addBuff(category:int, buff:BasicBuff) : void {
         var b:BasicBuff = null;
         var e:Effect = null;
         if(!this._categories[category])
         {
            this._categories[category] = new Array();
         }
         for each (b in this._categories[category])
         {
            e = Effect.getEffectById(buff.actionId);
            if((e.useDice) && (b.actionId == buff.actionId) && (buff.trigger == false) && (!(buff is StateBuff)))
            {
               if(!(buff.effects is EffectInstanceInteger))
               {
                  throw new Error("Tentative de cumulation d\'effets ambigue");
               }
               else
               {
                  b.param1 = b.param1 + buff.param1;
                  b.param2 = b.param2 + buff.param2;
                  b.param3 = b.param3 + buff.param3;
                  return;
               }
            }
            else
            {
               continue;
            }
         }
         b = buff.clone();
         this._categories[category].push(b);
      }
      
      private function getCategory(effect:Effect) : int {
         if(effect.characteristic == 71)
         {
            return CATEGORY_STATE;
         }
         if(effect.operator == "-")
         {
            if(effect.active)
            {
               return CATEGORY_ACTIVE_MALUS;
            }
            return CATEGORY_PASSIVE_MALUS;
         }
         if(effect.operator == "+")
         {
            if(effect.active)
            {
               return CATEGORY_ACTIVE_BONUS;
            }
            return CATEGORY_PASSIVE_BONUS;
         }
         return CATEGORY_OTHER;
      }
   }
}
