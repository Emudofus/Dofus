package com.ankamagames.dofus.datacenter.breeds
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.dofus.datacenter.appearance.SkinMapping;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class Breed extends Object implements IDataCenter
   {
      
      public function Breed() {
         super();
      }
      
      public static const MODULE:String = "Breeds";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Breed));
      
      private static var _skinsForBreed:Array = new Array();
      
      public static function getBreedById(param1:int) : Breed {
         return GameData.getObject(MODULE,param1) as Breed;
      }
      
      public static function getBreeds() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public static function getBreedFromSkin(param1:int) : Breed {
         var _loc3_:Object = null;
         var _loc4_:Breed = null;
         var _loc5_:String = null;
         var _loc2_:* = 0;
         if(!_skinsForBreed.length)
         {
            for each (_loc4_ in getBreeds())
            {
               _loc5_ = _loc4_.maleLook.split("|")[1];
               _loc5_ = _loc5_.split(",")[0];
               _skinsForBreed[_loc5_] = _loc4_.id;
               _skinsForBreed[SkinMapping.getSkinMappingById(int(_loc5_)).lowDefId] = _loc4_.id;
               _loc5_ = _loc4_.femaleLook.split("|")[1];
               _loc5_ = _loc5_.split(",")[0];
               _skinsForBreed[_loc5_] = _loc4_.id;
               _skinsForBreed[SkinMapping.getSkinMappingById(int(_loc5_)).lowDefId] = _loc4_.id;
            }
         }
         for (_loc3_ in _skinsForBreed)
         {
            if(_loc3_ == param1.toString())
            {
               _loc2_ = _skinsForBreed[_loc3_];
            }
         }
         return GameData.getObject(MODULE,_loc2_) as Breed;
      }
      
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
      
      public var spawnMap:uint;
      
      private var _shortName:String;
      
      private var _longName:String;
      
      private var _description:String;
      
      private var _gameplayDescription:String;
      
      private var _breedSpells:Vector.<Spell>;
      
      public function get shortName() : String {
         if(!this._shortName)
         {
            this._shortName = I18n.getText(this.shortNameId);
         }
         return this._shortName;
      }
      
      public function get longName() : String {
         if(!this._longName)
         {
            this._longName = I18n.getText(this.longNameId);
         }
         return this._longName;
      }
      
      public function get description() : String {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get gameplayDescription() : String {
         if(!this._gameplayDescription)
         {
            this._gameplayDescription = I18n.getText(this.gameplayDescriptionId);
         }
         return this._gameplayDescription;
      }
      
      public function get breedSpells() : Vector.<Spell> {
         var _loc1_:uint = 0;
         if(!this._breedSpells && !(Spell.getSpellById(1) == null))
         {
            this._breedSpells = new Vector.<Spell>();
            for each (_loc1_ in this.breedSpellsId)
            {
               this._breedSpells.push(Spell.getSpellById(_loc1_));
            }
         }
         return this._breedSpells;
      }
      
      public function get femaleLookWithColors() : TiphonEntityLook {
         var _loc1_:TiphonEntityLook = TiphonEntityLook.fromString(this.femaleLook);
         var _loc2_:int = this.femaleColors.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.setColor(_loc3_ + 1,this.femaleColors[_loc3_]);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get maleLookWithColors() : TiphonEntityLook {
         var _loc1_:TiphonEntityLook = TiphonEntityLook.fromString(this.maleLook);
         var _loc2_:int = this.maleColors.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.setColor(_loc3_ + 1,this.maleColors[_loc3_]);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getStatsPointsNeededForStrength(param1:uint) : uint {
         var _loc2_:* = undefined;
         for (_loc2_ in this.statsPointsForStrength)
         {
            if(param1 < this.statsPointsForStrength[_loc2_][0])
            {
               return this.statsPointsForStrength[_loc2_-1][1];
            }
         }
         return this.statsPointsForStrength[_loc2_][1];
      }
      
      public function getStatsPointsNeededForIntelligence(param1:uint) : uint {
         var _loc2_:* = undefined;
         for (_loc2_ in this.statsPointsForIntelligence)
         {
            if(param1 < this.statsPointsForIntelligence[_loc2_][0])
            {
               return this.statsPointsForIntelligence[_loc2_-1][1];
            }
         }
         return this.statsPointsForIntelligence[_loc2_][1];
      }
      
      public function getStatsPointsNeededForChance(param1:uint) : uint {
         var _loc2_:* = undefined;
         for (_loc2_ in this.statsPointsForChance)
         {
            if(param1 < this.statsPointsForChance[_loc2_][0])
            {
               return this.statsPointsForChance[_loc2_-1][1];
            }
         }
         return this.statsPointsForChance[_loc2_][1];
      }
      
      public function getStatsPointsNeededForAgility(param1:uint) : uint {
         var _loc2_:* = undefined;
         for (_loc2_ in this.statsPointsForAgility)
         {
            if(param1 < this.statsPointsForAgility[_loc2_][0])
            {
               return this.statsPointsForAgility[_loc2_-1][1];
            }
         }
         return this.statsPointsForAgility[_loc2_][1];
      }
      
      public function getStatsPointsNeededForVitality(param1:uint) : uint {
         var _loc2_:* = undefined;
         for (_loc2_ in this.statsPointsForVitality)
         {
            if(param1 < this.statsPointsForVitality[_loc2_][0])
            {
               return this.statsPointsForVitality[_loc2_-1][1];
            }
         }
         return this.statsPointsForVitality[_loc2_][1];
      }
      
      public function getStatsPointsNeededForWisdom(param1:uint) : uint {
         var _loc2_:* = undefined;
         for (_loc2_ in this.statsPointsForWisdom)
         {
            if(param1 < this.statsPointsForWisdom[_loc2_][0])
            {
               return this.statsPointsForWisdom[_loc2_-1][1];
            }
         }
         return this.statsPointsForWisdom[_loc2_][1];
      }
   }
}
