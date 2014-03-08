package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Spell extends Object implements IDataCenter
   {
      
      public function Spell() {
         this._spellLevels = [];
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Spell));
      
      public static const MODULE:String = "Spells";
      
      public static function getSpellById(param1:int) : Spell {
         return GameData.getObject(MODULE,param1) as Spell;
      }
      
      public static function getSpells() : Array {
         return GameData.getObjects(MODULE);
      }
      
      private var _indexedParam:Array;
      
      private var _indexedCriticalParam:Array;
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var typeId:uint;
      
      public var scriptParams:String;
      
      public var scriptParamsCritical:String;
      
      public var scriptId:int;
      
      public var scriptIdCritical:int;
      
      public var iconId:uint;
      
      public var spellLevels:Vector.<uint>;
      
      public var useParamCache:Boolean = true;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _spellLevels:Array;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get type() : SpellType {
         return SpellType.getSpellTypeById(this.typeId);
      }
      
      public function getSpellLevel(param1:int) : SpellLevel {
         if(!this._spellLevels[param1])
         {
            if(this.spellLevels.length >= param1 && param1 > 0)
            {
               this._spellLevels[param1] = SpellLevel.getLevelById(this.spellLevels[param1-1]);
            }
            else
            {
               this._spellLevels[param1] = SpellLevel.getLevelById(this.spellLevels[0]);
            }
         }
         return this._spellLevels[param1];
      }
      
      public function getScriptId(param1:Boolean=false) : int {
         if((param1) && (this.scriptIdCritical))
         {
            return this.scriptIdCritical;
         }
         return this.scriptId;
      }
      
      public function getParamByName(param1:String, param2:Boolean=false) : * {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         if((param2) && (this.scriptParamsCritical) && !(this.scriptParamsCritical == "null"))
         {
            if(!this._indexedCriticalParam || !this.useParamCache)
            {
               this._indexedCriticalParam = new Array();
               if(this.scriptParamsCritical)
               {
                  _loc3_ = this.scriptParamsCritical.split(",");
                  for each (_loc5_ in _loc3_)
                  {
                     _loc4_ = _loc5_.split(":");
                     this._indexedCriticalParam[_loc4_[0]] = this.getValue(_loc4_[1]);
                  }
               }
            }
            return this._indexedCriticalParam[param1];
         }
         if(!this._indexedParam || !this.useParamCache)
         {
            this._indexedParam = new Array();
            if(this.scriptParams)
            {
               _loc3_ = this.scriptParams.split(",");
               for each (_loc5_ in _loc3_)
               {
                  _loc4_ = _loc5_.split(":");
                  this._indexedParam[_loc4_[0]] = this.getValue(_loc4_[1]);
               }
            }
         }
         return this._indexedParam[param1];
      }
      
      private function getValue(param1:String) : * {
         var _loc3_:* = NaN;
         var _loc2_:RegExp = new RegExp("^[+-]?[0-9.]*$");
         if(param1.search(_loc2_) != -1)
         {
            _loc3_ = parseFloat(param1);
            return isNaN(_loc3_)?0:_loc3_;
         }
         return param1;
      }
      
      public function toString() : String {
         return this.name + " (" + this.id + ")";
      }
   }
}
