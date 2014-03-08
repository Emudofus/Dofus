package com.ankamagames.dofus.logic.game.fight.types
{
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   
   public class SpellDamage extends Object
   {
      
      public function SpellDamage() {
         super();
         this._effectDamages = new Vector.<EffectDamage>();
      }
      
      public var invulnerableState:Boolean;
      
      public var hasCriticalDamage:Boolean;
      
      public var hasCriticalShieldPointsRemoved:Boolean;
      
      public var hasCriticalLifePointsAdded:Boolean;
      
      private var _effectDamages:Vector.<EffectDamage>;
      
      private var _minDamage:int;
      
      public function get minDamage() : int {
         var _loc1_:EffectDamage = null;
         this._minDamage = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._minDamage = this._minDamage + _loc1_.minDamage;
         }
         return this._minDamage;
      }
      
      public function set minDamage(param1:int) : void {
         this._minDamage = param1;
      }
      
      private var _maxDamage:int;
      
      public function get maxDamage() : int {
         var _loc1_:EffectDamage = null;
         this._maxDamage = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._maxDamage = this._maxDamage + _loc1_.maxDamage;
         }
         return this._maxDamage;
      }
      
      public function set maxDamage(param1:int) : void {
         this._maxDamage = param1;
      }
      
      private var _minCriticalDamage:int;
      
      public function get minCriticalDamage() : int {
         var _loc1_:EffectDamage = null;
         this._minCriticalDamage = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._minCriticalDamage = this._minCriticalDamage + _loc1_.minCriticalDamage;
         }
         return this._minCriticalDamage;
      }
      
      public function set minCriticalDamage(param1:int) : void {
         this._minCriticalDamage = param1;
      }
      
      private var _maxCriticalDamage:int;
      
      public function get maxCriticalDamage() : int {
         var _loc1_:EffectDamage = null;
         this._maxCriticalDamage = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._maxCriticalDamage = this._maxCriticalDamage + _loc1_.maxCriticalDamage;
         }
         return this._maxCriticalDamage;
      }
      
      public function set maxCriticalDamage(param1:int) : void {
         this._maxCriticalDamage = param1;
      }
      
      public function get minErosionDamage() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.minErosionDamage;
         }
         return _loc1_;
      }
      
      public function get maxErosionDamage() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.maxErosionDamage;
         }
         return _loc1_;
      }
      
      public function get minCriticalErosionDamage() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.minCriticalErosionDamage;
         }
         return _loc1_;
      }
      
      public function get maxCriticalErosionDamage() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.maxCriticalErosionDamage;
         }
         return _loc1_;
      }
      
      private var _minShieldPointsRemoved:int;
      
      public function get minShieldPointsRemoved() : int {
         var _loc1_:EffectDamage = null;
         this._minShieldPointsRemoved = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._minShieldPointsRemoved = this._minShieldPointsRemoved + _loc1_.minShieldPointsRemoved;
         }
         return this._minShieldPointsRemoved;
      }
      
      public function set minShieldPointsRemoved(param1:int) : void {
         this._minShieldPointsRemoved = param1;
      }
      
      private var _maxShieldPointsRemoved:int;
      
      public function get maxShieldPointsRemoved() : int {
         var _loc1_:EffectDamage = null;
         this._maxShieldPointsRemoved = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._maxShieldPointsRemoved = this._maxShieldPointsRemoved + _loc1_.maxShieldPointsRemoved;
         }
         return this._maxShieldPointsRemoved;
      }
      
      public function set maxShieldPointsRemoved(param1:int) : void {
         this._maxShieldPointsRemoved = param1;
      }
      
      private var _minCriticalShieldPointsRemoved:int;
      
      public function get minCriticalShieldPointsRemoved() : int {
         var _loc1_:EffectDamage = null;
         this._minCriticalShieldPointsRemoved = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._minCriticalShieldPointsRemoved = this._minCriticalShieldPointsRemoved + _loc1_.minCriticalShieldPointsRemoved;
         }
         return this._minCriticalShieldPointsRemoved;
      }
      
      public function set minCriticalShieldPointsRemoved(param1:int) : void {
         this._minCriticalShieldPointsRemoved = param1;
      }
      
      private var _maxCriticalShieldPointsRemoved:int;
      
      public function get maxCriticalShieldPointsRemoved() : int {
         var _loc1_:EffectDamage = null;
         this._maxCriticalShieldPointsRemoved = 0;
         for each (_loc1_ in this._effectDamages)
         {
            this._maxCriticalShieldPointsRemoved = this._maxCriticalShieldPointsRemoved + _loc1_.maxCriticalShieldPointsRemoved;
         }
         return this._maxCriticalShieldPointsRemoved;
      }
      
      public function set maxCriticalShieldPointsRemoved(param1:int) : void {
         this._maxCriticalShieldPointsRemoved = param1;
      }
      
      public function get minLifePointsAdded() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.minLifePointsAdded;
         }
         return _loc1_;
      }
      
      public function get maxLifePointsAdded() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.maxLifePointsAdded;
         }
         return _loc1_;
      }
      
      public function get minCriticalLifePointsAdded() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.minCriticalLifePointsAdded;
         }
         return _loc1_;
      }
      
      public function get maxCriticalLifePointsAdded() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.maxCriticalLifePointsAdded;
         }
         return _loc1_;
      }
      
      public function get lifePointsAddedBasedOnLifePercent() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.lifePointsAddedBasedOnLifePercent;
         }
         return _loc1_;
      }
      
      public function get criticalLifePointsAddedBasedOnLifePercent() : int {
         var _loc1_:* = 0;
         var _loc2_:EffectDamage = null;
         for each (_loc2_ in this._effectDamages)
         {
            _loc1_ = _loc1_ + _loc2_.criticalLifePointsAddedBasedOnLifePercent;
         }
         return _loc1_;
      }
      
      public function updateDamage() : void {
      }
      
      public function addEffectDamage(param1:EffectDamage) : void {
         this._effectDamages.push(param1);
      }
      
      public function get effectDamages() : Vector.<EffectDamage> {
         return this._effectDamages;
      }
      
      public function get hasRandomEffects() : Boolean {
         var _loc1_:EffectDamage = null;
         for each (_loc1_ in this._effectDamages)
         {
            if(_loc1_.random > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get random() : int {
         var _loc2_:EffectDamage = null;
         var _loc1_:* = -1;
         var _loc3_:* = true;
         for each (_loc2_ in this._effectDamages)
         {
            if(_loc2_.random > 0)
            {
               if(_loc3_)
               {
                  _loc1_ = _loc2_.random;
                  _loc3_ = false;
                  continue;
               }
               return -1;
            }
         }
         return _loc1_;
      }
      
      public function get element() : int {
         var _loc2_:EffectDamage = null;
         var _loc1_:* = -1;
         var _loc3_:* = true;
         for each (_loc2_ in this._effectDamages)
         {
            if(_loc2_.element != -1)
            {
               if(_loc3_)
               {
                  _loc1_ = _loc2_.element;
                  _loc3_ = false;
                  continue;
               }
               return -1;
            }
         }
         return _loc1_;
      }
      
      private function get damageConvertedToHeal() : Boolean {
         var _loc1_:EffectDamage = null;
         for each (_loc1_ in this._effectDamages)
         {
            if(_loc1_.damageConvertedToHeal)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getElementTextColor(param1:int) : String {
         var _loc2_:String = null;
         if(param1 == -1)
         {
            _loc2_ = "fight.text.multi";
         }
         else
         {
            switch(param1)
            {
               case 0:
                  _loc2_ = "fight.text.neutral";
                  break;
               case 1:
                  _loc2_ = "fight.text.earth";
                  break;
               case 2:
                  _loc2_ = "fight.text.fire";
                  break;
               case 3:
                  _loc2_ = "fight.text.water";
                  break;
               case 4:
                  _loc2_ = "fight.text.air";
                  break;
            }
         }
         return XmlConfig.getInstance().getEntry("colors." + _loc2_);
      }
      
      private function getEffectString(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int=0) : String {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc7_:* = "";
         if(param1 == param2)
         {
            _loc8_ = String(param2);
         }
         else
         {
            _loc8_ = param1 + (param2 != 0?" - " + param2:"");
         }
         if(param5)
         {
            if(param3 == param4)
            {
               _loc9_ = String(param4);
            }
            else
            {
               _loc9_ = param3 + (param4 != 0?" - " + param4:"");
            }
         }
         if(_loc8_)
         {
            _loc7_ = _loc8_;
         }
         if(_loc9_)
         {
            if(_loc8_)
            {
               _loc7_ = _loc7_ + (" (<b>" + _loc9_ + "</b>)");
            }
         }
         return param6 > 0?param6 + "% " + _loc7_:_loc7_;
      }
      
      public function toString() : String {
         var _loc5_:EffectDamage = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc1_:* = "";
         var _loc2_:String = this.getElementTextColor(this.element);
         var _loc3_:* = "0x9966CC";
         var _loc4_:int = OptionManager.getOptionManager("chat")["channelColor" + ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG];
         if(this.hasRandomEffects)
         {
            for each (_loc5_ in this._effectDamages)
            {
               if(_loc5_.element != -1)
               {
                  _loc1_ = _loc1_ + (HtmlManager.addTag(!this.damageConvertedToHeal?this.getEffectString(_loc5_.minDamage,_loc5_.maxDamage,_loc5_.minCriticalDamage,_loc5_.maxCriticalDamage,_loc5_.hasCritical,_loc5_.random):this.getEffectString(_loc5_.minLifePointsAdded,_loc5_.maxLifePointsAdded,_loc5_.minCriticalLifePointsAdded,_loc5_.maxCriticalLifePointsAdded,_loc5_.hasCritical,_loc5_.random),HtmlManager.SPAN,{"color":(!this.damageConvertedToHeal?this.getElementTextColor(_loc5_.element):_loc4_)}) + "\n");
               }
            }
         }
         else
         {
            if(!this.damageConvertedToHeal)
            {
               _loc8_ = this.getEffectString(this._minDamage,this._maxDamage,this._minCriticalDamage,this._maxCriticalDamage,this.hasCriticalDamage);
               _loc8_ = !this.invulnerableState?_loc8_:SpellState.getSpellStateById(56).name;
               _loc1_ = _loc1_ + (HtmlManager.addTag(_loc8_,HtmlManager.SPAN,{"color":_loc2_}) + "\n");
            }
            if(!this.invulnerableState)
            {
               if(!(this._minShieldPointsRemoved == 0) && !(this._maxShieldPointsRemoved == 0) && !(this._minCriticalShieldPointsRemoved == 0) && !(this._maxCriticalShieldPointsRemoved == 0))
               {
                  _loc6_ = this.getEffectString(this._minShieldPointsRemoved,this._maxShieldPointsRemoved,this._minCriticalShieldPointsRemoved,this._maxCriticalShieldPointsRemoved,this.hasCriticalShieldPointsRemoved);
               }
               if(_loc6_)
               {
                  _loc1_ = _loc1_ + (HtmlManager.addTag(_loc6_,HtmlManager.SPAN,{"color":_loc3_}) + "\n");
               }
            }
            if(!(this.minLifePointsAdded == 0) && !(this.maxLifePointsAdded == 0) && !(this.minCriticalLifePointsAdded == 0) && !(this.maxCriticalLifePointsAdded == 0))
            {
               _loc7_ = this.getEffectString(this.minLifePointsAdded,this.maxLifePointsAdded,this.minCriticalLifePointsAdded,this.maxCriticalLifePointsAdded,this.hasCriticalLifePointsAdded);
            }
            if(_loc7_)
            {
               _loc1_ = _loc1_ + HtmlManager.addTag(_loc7_,HtmlManager.SPAN,{"color":_loc4_});
            }
         }
         return _loc1_;
      }
   }
}
