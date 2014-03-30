package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import __AS3__.vec.*;
   
   public class SpellDamage extends Object
   {
      
      public function SpellDamage() {
         super();
         this._effectDamages = new Vector.<EffectDamage>();
      }
      
      public var invulnerableState:Boolean;
      
      public var unhealableState:Boolean;
      
      public var hasCriticalDamage:Boolean;
      
      public var hasCriticalShieldPointsRemoved:Boolean;
      
      public var hasCriticalLifePointsAdded:Boolean;
      
      public var isHealingSpell:Boolean;
      
      public var hasHeal:Boolean;
      
      private var _effectDamages:Vector.<EffectDamage>;
      
      private var _minDamage:int;
      
      public function get minDamage() : int {
         var ed:EffectDamage = null;
         this._minDamage = 0;
         for each (ed in this._effectDamages)
         {
            this._minDamage = this._minDamage + ed.minDamage;
         }
         return this._minDamage;
      }
      
      public function set minDamage(pMinDamage:int) : void {
         this._minDamage = pMinDamage;
      }
      
      private var _maxDamage:int;
      
      public function get maxDamage() : int {
         var ed:EffectDamage = null;
         this._maxDamage = 0;
         for each (ed in this._effectDamages)
         {
            this._maxDamage = this._maxDamage + ed.maxDamage;
         }
         return this._maxDamage;
      }
      
      public function set maxDamage(pMaxDamage:int) : void {
         this._maxDamage = pMaxDamage;
      }
      
      private var _minCriticalDamage:int;
      
      public function get minCriticalDamage() : int {
         var ed:EffectDamage = null;
         this._minCriticalDamage = 0;
         for each (ed in this._effectDamages)
         {
            this._minCriticalDamage = this._minCriticalDamage + ed.minCriticalDamage;
         }
         return this._minCriticalDamage;
      }
      
      public function set minCriticalDamage(pMinCriticalDamage:int) : void {
         this._minCriticalDamage = pMinCriticalDamage;
      }
      
      private var _maxCriticalDamage:int;
      
      public function get maxCriticalDamage() : int {
         var ed:EffectDamage = null;
         this._maxCriticalDamage = 0;
         for each (ed in this._effectDamages)
         {
            this._maxCriticalDamage = this._maxCriticalDamage + ed.maxCriticalDamage;
         }
         return this._maxCriticalDamage;
      }
      
      public function set maxCriticalDamage(pMaxCriticalDamage:int) : void {
         this._maxCriticalDamage = pMaxCriticalDamage;
      }
      
      public function get minErosionDamage() : int {
         var minErosion:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            minErosion = minErosion + ed.minErosionDamage;
         }
         return minErosion;
      }
      
      public function get maxErosionDamage() : int {
         var maxErosion:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            maxErosion = maxErosion + ed.maxErosionDamage;
         }
         return maxErosion;
      }
      
      public function get minCriticalErosionDamage() : int {
         var minCriticalErosion:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            minCriticalErosion = minCriticalErosion + ed.minCriticalErosionDamage;
         }
         return minCriticalErosion;
      }
      
      public function get maxCriticalErosionDamage() : int {
         var maxCriticalErosion:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            maxCriticalErosion = maxCriticalErosion + ed.maxCriticalErosionDamage;
         }
         return maxCriticalErosion;
      }
      
      private var _minShieldPointsRemoved:int;
      
      public function get minShieldPointsRemoved() : int {
         var ed:EffectDamage = null;
         this._minShieldPointsRemoved = 0;
         for each (ed in this._effectDamages)
         {
            this._minShieldPointsRemoved = this._minShieldPointsRemoved + ed.minShieldPointsRemoved;
         }
         return this._minShieldPointsRemoved;
      }
      
      public function set minShieldPointsRemoved(pMinShieldPointsRemoved:int) : void {
         this._minShieldPointsRemoved = pMinShieldPointsRemoved;
      }
      
      private var _maxShieldPointsRemoved:int;
      
      public function get maxShieldPointsRemoved() : int {
         var ed:EffectDamage = null;
         this._maxShieldPointsRemoved = 0;
         for each (ed in this._effectDamages)
         {
            this._maxShieldPointsRemoved = this._maxShieldPointsRemoved + ed.maxShieldPointsRemoved;
         }
         return this._maxShieldPointsRemoved;
      }
      
      public function set maxShieldPointsRemoved(pMaxShieldPointsRemoved:int) : void {
         this._maxShieldPointsRemoved = pMaxShieldPointsRemoved;
      }
      
      private var _minCriticalShieldPointsRemoved:int;
      
      public function get minCriticalShieldPointsRemoved() : int {
         var ed:EffectDamage = null;
         this._minCriticalShieldPointsRemoved = 0;
         for each (ed in this._effectDamages)
         {
            this._minCriticalShieldPointsRemoved = this._minCriticalShieldPointsRemoved + ed.minCriticalShieldPointsRemoved;
         }
         return this._minCriticalShieldPointsRemoved;
      }
      
      public function set minCriticalShieldPointsRemoved(pMinCriticalShieldPointsRemoved:int) : void {
         this._minCriticalShieldPointsRemoved = pMinCriticalShieldPointsRemoved;
      }
      
      private var _maxCriticalShieldPointsRemoved:int;
      
      public function get maxCriticalShieldPointsRemoved() : int {
         var ed:EffectDamage = null;
         this._maxCriticalShieldPointsRemoved = 0;
         for each (ed in this._effectDamages)
         {
            this._maxCriticalShieldPointsRemoved = this._maxCriticalShieldPointsRemoved + ed.maxCriticalShieldPointsRemoved;
         }
         return this._maxCriticalShieldPointsRemoved;
      }
      
      public function set maxCriticalShieldPointsRemoved(pMaxCriticalShieldPointsRemoved:int) : void {
         this._maxCriticalShieldPointsRemoved = pMaxCriticalShieldPointsRemoved;
      }
      
      public function get minLifePointsAdded() : int {
         var minLife:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            minLife = minLife + ed.minLifePointsAdded;
         }
         return minLife;
      }
      
      public function get maxLifePointsAdded() : int {
         var maxLife:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            maxLife = maxLife + ed.maxLifePointsAdded;
         }
         return maxLife;
      }
      
      public function get minCriticalLifePointsAdded() : int {
         var minCriticalLife:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            minCriticalLife = minCriticalLife + ed.minCriticalLifePointsAdded;
         }
         return minCriticalLife;
      }
      
      public function get maxCriticalLifePointsAdded() : int {
         var maxCriticalLife:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            maxCriticalLife = maxCriticalLife + ed.maxCriticalLifePointsAdded;
         }
         return maxCriticalLife;
      }
      
      public function get lifePointsAddedBasedOnLifePercent() : int {
         var lifePointsFromPercent:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            lifePointsFromPercent = lifePointsFromPercent + ed.lifePointsAddedBasedOnLifePercent;
         }
         return lifePointsFromPercent;
      }
      
      public function get criticalLifePointsAddedBasedOnLifePercent() : int {
         var criticalLifePointsFromPercent:* = 0;
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            criticalLifePointsFromPercent = criticalLifePointsFromPercent + ed.criticalLifePointsAddedBasedOnLifePercent;
         }
         return criticalLifePointsFromPercent;
      }
      
      public function updateDamage() : void {
      }
      
      public function addEffectDamage(pEffectDamage:EffectDamage) : void {
         this._effectDamages.push(pEffectDamage);
      }
      
      public function get effectDamages() : Vector.<EffectDamage> {
         return this._effectDamages;
      }
      
      public function get hasRandomEffects() : Boolean {
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            if(ed.random > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get random() : int {
         var ed:EffectDamage = null;
         var r:int = -1;
         var first:Boolean = true;
         for each (ed in this._effectDamages)
         {
            if(ed.random > 0)
            {
               if(first)
               {
                  r = ed.random;
                  first = false;
               }
               else
               {
                  if(ed.random != r)
                  {
                     return -1;
                  }
               }
            }
         }
         return r;
      }
      
      public function get element() : int {
         var ed:EffectDamage = null;
         var hasPushDamages:* = false;
         var element:int = -1;
         var first:Boolean = true;
         for each (ed in this._effectDamages)
         {
            if(ed.element != -1)
            {
               if(first)
               {
                  element = ed.element;
                  first = false;
               }
               else
               {
                  if(ed.element != element)
                  {
                     return -1;
                  }
               }
            }
            if(ed.effectId == 5)
            {
               hasPushDamages = true;
            }
         }
         if((!(element == -1)) && (hasPushDamages))
         {
            element = -1;
         }
         return element;
      }
      
      private function get damageConvertedToHeal() : Boolean {
         var ed:EffectDamage = null;
         for each (ed in this._effectDamages)
         {
            if(ed.damageConvertedToHeal)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getElementTextColor(pElementId:int) : String {
         var color:String = null;
         if(pElementId == -1)
         {
            color = "fight.text.multi";
         }
         else
         {
            switch(pElementId)
            {
               case 0:
                  color = "fight.text.neutral";
                  break;
               case 1:
                  color = "fight.text.earth";
                  break;
               case 2:
                  color = "fight.text.fire";
                  break;
               case 3:
                  color = "fight.text.water";
                  break;
               case 4:
                  color = "fight.text.air";
                  break;
            }
         }
         return XmlConfig.getInstance().getEntry("colors." + color);
      }
      
      private function getEffectString(pMin:int, pMax:int, pMinCritical:int, pMaxCritical:int, pHasCritical:Boolean, pRandom:int=0) : String {
         var normal:String = null;
         var critical:String = null;
         var effectStr:String = "";
         if(pMin == pMax)
         {
            normal = String(pMax);
         }
         else
         {
            normal = pMin + (!(pMax == 0)?" - " + pMax:"");
         }
         if(pHasCritical)
         {
            if(pMinCritical == pMaxCritical)
            {
               critical = String(pMaxCritical);
            }
            else
            {
               critical = pMinCritical + (!(pMaxCritical == 0)?" - " + pMaxCritical:"");
            }
         }
         if(normal)
         {
            effectStr = normal;
         }
         if(critical)
         {
            if(normal)
            {
               effectStr = effectStr + (" (<b>" + critical + "</b>)");
            }
         }
         return pRandom > 0?pRandom + "% " + effectStr:effectStr;
      }
      
      public var effectIcons:Array;
      
      public function toString() : String {
         var ed:EffectDamage = null;
         var effText:String = null;
         var shieldStr:String = null;
         var dmgStr:String = null;
         var healStr:String = null;
         var finalStr:String = "";
         var damageColor:String = this.getElementTextColor(this.element);
         var shieldColor:String = "0x9966CC";
         var healColor:int = OptionManager.getOptionManager("chat")["channelColor" + ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG];
         this.effectIcons = new Array();
         if((this.hasRandomEffects) && (!this.invulnerableState))
         {
            for each (ed in this._effectDamages)
            {
               if(ed.element != -1)
               {
                  if(this.damageConvertedToHeal)
                  {
                     this.effectIcons.push("lifePoints");
                     effText = this.getEffectString(ed.minLifePointsAdded,ed.maxLifePointsAdded,ed.minCriticalLifePointsAdded,ed.maxCriticalLifePointsAdded,ed.hasCritical,ed.random);
                  }
                  else
                  {
                     this.effectIcons.push(null);
                     effText = this.getEffectString(ed.minDamage,ed.maxDamage,ed.minCriticalDamage,ed.maxCriticalDamage,ed.hasCritical,ed.random);
                  }
                  finalStr = finalStr + (HtmlManager.addTag(effText,HtmlManager.SPAN,{"color":(!this.damageConvertedToHeal?this.getElementTextColor(ed.element):healColor)}) + "\n");
               }
            }
         }
         else
         {
            if((!this.isHealingSpell) && (!this.damageConvertedToHeal))
            {
               dmgStr = this.getEffectString(this._minDamage,this._maxDamage,this._minCriticalDamage,this._maxCriticalDamage,this.hasCriticalDamage);
               dmgStr = !this.invulnerableState?dmgStr:SpellState.getSpellStateById(56).name;
               this.effectIcons.push(null);
               finalStr = finalStr + (HtmlManager.addTag(dmgStr,HtmlManager.SPAN,{"color":damageColor}) + "\n");
            }
            if((!this.isHealingSpell) && (!this.invulnerableState))
            {
               if((!(this._minShieldPointsRemoved == 0)) && (!(this._maxShieldPointsRemoved == 0)))
               {
                  shieldStr = this.getEffectString(this._minShieldPointsRemoved,this._maxShieldPointsRemoved,this._minCriticalShieldPointsRemoved,this._maxCriticalShieldPointsRemoved,this.hasCriticalShieldPointsRemoved);
               }
               if(shieldStr)
               {
                  this.effectIcons.push(null);
                  finalStr = finalStr + (HtmlManager.addTag(shieldStr,HtmlManager.SPAN,{"color":shieldColor}) + "\n");
               }
            }
            if((this.hasHeal) || (this.damageConvertedToHeal))
            {
               healStr = this.getEffectString(this.minLifePointsAdded,this.maxLifePointsAdded,this.minCriticalLifePointsAdded,this.maxCriticalLifePointsAdded,this.hasCriticalLifePointsAdded);
               if(this.unhealableState)
               {
                  this.effectIcons.push(null);
                  healStr = SpellState.getSpellStateById(76).name;
               }
               else
               {
                  this.effectIcons.push("lifePoints");
               }
               finalStr = finalStr + HtmlManager.addTag(healStr,HtmlManager.SPAN,{"color":healColor});
            }
         }
         return finalStr;
      }
   }
}
