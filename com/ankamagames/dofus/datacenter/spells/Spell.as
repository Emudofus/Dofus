package com.ankamagames.dofus.datacenter.spells
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Spell extends Object implements IDataCenter
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Spell));
        private static const MODULE:String = "Spells";

        public function Spell()
        {
            this._spellLevels = [];
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public function get type() : SpellType
        {
            return SpellType.getSpellTypeById(this.typeId);
        }// end function

        public function getSpellLevel(param1:int) : SpellLevel
        {
            if (!this._spellLevels[param1])
            {
                this._spellLevels[param1] = SpellLevel.getLevelById(this.spellLevels[(param1 - 1)]);
            }
            return this._spellLevels[param1];
        }// end function

        public function getScriptId(param1:Boolean = false) : int
        {
            if (param1 && this.scriptIdCritical)
            {
                return this.scriptIdCritical;
            }
            return this.scriptId;
        }// end function

        public function getParamByName(param1:String, param2:Boolean = false)
        {
            var _loc_3:Array = null;
            var _loc_4:Array = null;
            var _loc_5:String = null;
            if (param2 && this.scriptParamsCritical && this.scriptParamsCritical != "null")
            {
                if (!this._indexedCriticalParam || !this.useParamCache)
                {
                    this._indexedCriticalParam = new Array();
                    if (this.scriptParamsCritical)
                    {
                        _loc_3 = this.scriptParamsCritical.split(",");
                        for each (_loc_5 in _loc_3)
                        {
                            
                            _loc_4 = _loc_5.split(":");
                            if ((_loc_4[1] as String).indexOf(";") == -1)
                            {
                                this._indexedCriticalParam[_loc_4[0]] = parseFloat(_loc_4[1]);
                                continue;
                            }
                            this._indexedCriticalParam[_loc_4[0]] = _loc_4[1];
                        }
                    }
                }
                return this._indexedCriticalParam[param1];
            }
            else
            {
                this._indexedParam = new Array();
                _loc_3 = this.scriptParams.split(",");
                for each (_loc_5 in _loc_3)
                {
                    
                    _loc_4 = _loc_5.split(":");
                    if ((_loc_4[1] as String).indexOf(";") == -1)
                    {
                        this._indexedParam[_loc_4[0]] = parseFloat(_loc_4[1]);
                        continue;
                    }
                }
                this._indexedParam[_loc_4[0]] = _loc_4[1];
            }
            return this._indexedParam[param1];
        }// end function

        public static function getSpellById(param1:int) : Spell
        {
            return GameData.getObject(MODULE, param1) as Spell;
        }// end function

        public static function getSpells() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
