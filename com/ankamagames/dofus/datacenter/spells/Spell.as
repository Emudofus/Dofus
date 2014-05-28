package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Spell extends Object implements IDataCenter
   {
      
      public function Spell() {
         this._spellLevels = [];
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "Spells";
      
      public static function getSpellById(id:int) : Spell {
         return GameData.getObject(MODULE,id) as Spell;
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
      
      public var verbose_cast:Boolean;
      
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
      
      public function getSpellLevel(level:int) : SpellLevel {
         if(!this._spellLevels[level])
         {
            if((this.spellLevels.length >= level) && (level > 0))
            {
               this._spellLevels[level] = SpellLevel.getLevelById(this.spellLevels[level - 1]);
            }
            else
            {
               this._spellLevels[level] = SpellLevel.getLevelById(this.spellLevels[0]);
            }
         }
         return this._spellLevels[level];
      }
      
      public function getScriptId(critical:Boolean = false) : int {
         if((critical) && (this.scriptIdCritical))
         {
            return this.scriptIdCritical;
         }
         return this.scriptId;
      }
      
      public function getParamByName(name:String, critical:Boolean = false) : * {
         var tmp:Array = null;
         var tmp2:Array = null;
         var param:String = null;
         if((critical) && (this.scriptParamsCritical) && (!(this.scriptParamsCritical == "null")))
         {
            if((!this._indexedCriticalParam) || (!this.useParamCache))
            {
               this._indexedCriticalParam = new Array();
               if(this.scriptParamsCritical)
               {
                  tmp = this.scriptParamsCritical.split(",");
                  for each(param in tmp)
                  {
                     tmp2 = param.split(":");
                     this._indexedCriticalParam[tmp2[0]] = this.getValue(tmp2[1]);
                  }
               }
            }
            return this._indexedCriticalParam[name];
         }
         if((!this._indexedParam) || (!this.useParamCache))
         {
            this._indexedParam = new Array();
            if(this.scriptParams)
            {
               tmp = this.scriptParams.split(",");
               for each(param in tmp)
               {
                  tmp2 = param.split(":");
                  this._indexedParam[tmp2[0]] = this.getValue(tmp2[1]);
               }
            }
         }
         return this._indexedParam[name];
      }
      
      private function getValue(str:String) : * {
         var num:* = NaN;
         var regNum:RegExp = new RegExp("^[+-]?[0-9.]*$");
         if(str.search(regNum) != -1)
         {
            num = parseFloat(str);
            return isNaN(num)?0:num;
         }
         return str;
      }
      
      public function toString() : String {
         return this.name + " (" + this.id + ")";
      }
   }
}
