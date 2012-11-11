package com.ankamagames.dofus.datacenter.breeds
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class Breed extends Object implements IDataCenter
    {
        public var id:int;
        public var shortNameId:uint;
        public var longNameId:uint;
        public var descriptionId:uint;
        public var gameplayDescriptionId:uint;
        public var maleLook:String;
        public var femaleLook:String;
        public var creatureBonesId:uint;
        public var maleArtwork:int;
        public var femaleArtwork:int;
        public var statsPointsForStrength:Vector.<Vector.<uint>>;
        public var statsPointsForIntelligence:Vector.<Vector.<uint>>;
        public var statsPointsForChance:Vector.<Vector.<uint>>;
        public var statsPointsForAgility:Vector.<Vector.<uint>>;
        public var statsPointsForVitality:Vector.<Vector.<uint>>;
        public var statsPointsForWisdom:Vector.<Vector.<uint>>;
        public var breedSpellsId:Vector.<uint>;
        public var maleColors:Vector.<uint>;
        public var femaleColors:Vector.<uint>;
        public var alternativeMaleSkin:Vector.<uint>;
        public var alternativeFemaleSkin:Vector.<uint>;
        private var _shortName:String;
        private var _longName:String;
        private var _description:String;
        private var _gameplayDescription:String;
        private var _breedSpells:Vector.<Spell>;
        private static const MODULE:String = "Breeds";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Breed));
        private static var _skinsForBreed:Array = new Array();

        public function Breed()
        {
            return;
        }// end function

        public function get shortName() : String
        {
            if (!this._shortName)
            {
                this._shortName = I18n.getText(this.shortNameId);
            }
            return this._shortName;
        }// end function

        public function get longName() : String
        {
            if (!this._longName)
            {
                this._longName = I18n.getText(this.longNameId);
            }
            return this._longName;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public function get gameplayDescription() : String
        {
            if (!this._gameplayDescription)
            {
                this._gameplayDescription = I18n.getText(this.gameplayDescriptionId);
            }
            return this._gameplayDescription;
        }// end function

        public function get breedSpells() : Vector.<Spell>
        {
            var _loc_1:* = 0;
            if (!this._breedSpells && Spell.getSpellById(1) != null)
            {
                this._breedSpells = new Vector.<Spell>;
                for each (_loc_1 in this.breedSpellsId)
                {
                    
                    this._breedSpells.push(Spell.getSpellById(_loc_1));
                }
            }
            return this._breedSpells;
        }// end function

        public function get femaleLookWithColors() : TiphonEntityLook
        {
            var _loc_1:* = TiphonEntityLook.fromString(this.femaleLook);
            var _loc_2:* = this.femaleColors.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1.setColor((_loc_3 + 1), this.femaleColors[_loc_3]);
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function get maleLookWithColors() : TiphonEntityLook
        {
            var _loc_1:* = TiphonEntityLook.fromString(this.maleLook);
            var _loc_2:* = this.maleColors.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1.setColor((_loc_3 + 1), this.maleColors[_loc_3]);
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function getStatsPointsNeededForStrength(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.statsPointsForStrength)
            {
                
                if (param1 < this.statsPointsForStrength[_loc_2][0])
                {
                    return this.statsPointsForStrength[(_loc_2 - 1)][1];
                }
            }
            return this.statsPointsForStrength[_loc_2][1];
        }// end function

        public function getStatsPointsNeededForIntelligence(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.statsPointsForIntelligence)
            {
                
                if (param1 < this.statsPointsForIntelligence[_loc_2][0])
                {
                    return this.statsPointsForIntelligence[(_loc_2 - 1)][1];
                }
            }
            return this.statsPointsForIntelligence[_loc_2][1];
        }// end function

        public function getStatsPointsNeededForChance(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.statsPointsForChance)
            {
                
                if (param1 < this.statsPointsForChance[_loc_2][0])
                {
                    return this.statsPointsForChance[(_loc_2 - 1)][1];
                }
            }
            return this.statsPointsForChance[_loc_2][1];
        }// end function

        public function getStatsPointsNeededForAgility(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.statsPointsForAgility)
            {
                
                if (param1 < this.statsPointsForAgility[_loc_2][0])
                {
                    return this.statsPointsForAgility[(_loc_2 - 1)][1];
                }
            }
            return this.statsPointsForAgility[_loc_2][1];
        }// end function

        public function getStatsPointsNeededForVitality(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.statsPointsForVitality)
            {
                
                if (param1 < this.statsPointsForVitality[_loc_2][0])
                {
                    return this.statsPointsForVitality[(_loc_2 - 1)][1];
                }
            }
            return this.statsPointsForVitality[_loc_2][1];
        }// end function

        public function getStatsPointsNeededForWisdom(param1:uint) : uint
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.statsPointsForWisdom)
            {
                
                if (param1 < this.statsPointsForWisdom[_loc_2][0])
                {
                    return this.statsPointsForWisdom[(_loc_2 - 1)][1];
                }
            }
            return this.statsPointsForWisdom[_loc_2][1];
        }// end function

        public static function getBreedById(param1:int) : Breed
        {
            return GameData.getObject(MODULE, param1) as Breed;
        }// end function

        public static function getBreeds() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

        public static function getBreedFromSkin(param1:int) : Breed
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = 0;
            if (!_skinsForBreed.length)
            {
                for each (_loc_4 in getBreeds())
                {
                    
                    for each (_loc_5 in _loc_4.alternativeMaleSkin)
                    {
                        
                        _skinsForBreed[_loc_5.toString()] = _loc_4.id;
                    }
                    for each (_loc_6 in _loc_4.alternativeFemaleSkin)
                    {
                        
                        _skinsForBreed[_loc_6.toString()] = _loc_4.id;
                    }
                }
            }
            for (_loc_3 in _skinsForBreed)
            {
                
                if (_loc_3 == param1.toString())
                {
                    _loc_2 = _skinsForBreed[_loc_3];
                    continue;
                }
            }
            return GameData.getObject(MODULE, _loc_2) as Breed;
        }// end function

    }
}
