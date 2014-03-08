package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.data.IPostInit;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.appearance.Appearance;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.CensoredContentManager;
   
   public class Item extends Object implements IPostInit, IDataCenter
   {
      
      public function Item() {
         super();
      }
      
      public static const MODULE:String = "Items";
      
      private static const SUPERTYPE_NOT_EQUIPABLE:Array = [9,14,15,16,17,18,6,19,21,20,8,22];
      
      private static const FILTER_EQUIPEMENT:Array = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false,false,false,false,false,false,false,false,true,true];
      
      private static const FILTER_CONSUMABLES:Array = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
      
      private static const FILTER_RESSOURCES:Array = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
      
      private static const FILTER_QUEST:Array = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false];
      
      public static const EQUIPEMENT_CATEGORY:uint = 0;
      
      public static const CONSUMABLES_CATEGORY:uint = 1;
      
      public static const RESSOURCES_CATEGORY:uint = 2;
      
      public static const QUEST_CATEGORY:uint = 3;
      
      public static const OTHER_CATEGORY:uint = 4;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Item));
      
      public static function getItemById(param1:uint, param2:Boolean=true) : Item {
         var _loc3_:Item = GameData.getObject(MODULE,param1) as Item;
         if((_loc3_) || !param2)
         {
            return _loc3_;
         }
         _log.error("Impossible de trouver l\'objet " + param1 + ", remplacement par l\'objet 666");
         return GameData.getObject(MODULE,666) as Item;
      }
      
      public static function getItems() : Array {
         return GameData.getObjects(MODULE);
      }
      
      private static var _censoredIcons:Dictionary;
      
      public var id:int;
      
      public var nameId:uint;
      
      public var typeId:uint;
      
      public var descriptionId:uint;
      
      public var iconId:uint;
      
      public var level:uint;
      
      public var realWeight:uint;
      
      public var cursed:Boolean;
      
      public var useAnimationId:int;
      
      public var usable:Boolean;
      
      public var targetable:Boolean;
      
      public var exchangeable:Boolean;
      
      public var price:Number;
      
      public var twoHanded:Boolean;
      
      public var etheral:Boolean;
      
      public var itemSetId:int;
      
      public var criteria:String;
      
      public var criteriaTarget:String;
      
      public var hideEffects:Boolean;
      
      public var enhanceable:Boolean;
      
      public var nonUsableOnAnother:Boolean;
      
      public var appearanceId:uint;
      
      public var secretRecipe:Boolean;
      
      public var dropMonsterIds:Vector.<uint>;
      
      public var recipeSlots:uint;
      
      public var recipeIds:Vector.<uint>;
      
      public var bonusIsSecret:Boolean;
      
      public var possibleEffects:Vector.<EffectInstance>;
      
      public var favoriteSubAreas:Vector.<uint>;
      
      public var favoriteSubAreasBonus:uint;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _type:ItemType;
      
      private var _weight:uint;
      
      private var _itemSet:ItemSet;
      
      private var _appearance:TiphonEntityLook;
      
      private var _conditions:GroupItemCriterion;
      
      private var _conditionsTarget:GroupItemCriterion;
      
      private var _recipes:Array;
      
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
            if(this.etheral)
            {
               this._description = I18n.getUiText("ui.common.etherealWeaponDescription");
            }
            else
            {
               this._description = I18n.getText(this.descriptionId);
            }
         }
         return this._description;
      }
      
      public function get weight() : uint {
         return this._weight;
      }
      
      public function set weight(param1:uint) : void {
         this._weight = param1;
      }
      
      public function get type() : Object {
         if(!this._type)
         {
            this._type = ItemType.getItemTypeById(this.typeId);
         }
         return this._type;
      }
      
      public function get isWeapon() : Boolean {
         return false;
      }
      
      public function get itemSet() : ItemSet {
         if(!this._itemSet)
         {
            this._itemSet = ItemSet.getItemSetById(this.itemSetId);
         }
         return this._itemSet;
      }
      
      public function get appearance() : TiphonEntityLook {
         var _loc1_:Appearance = null;
         if(!this._appearance)
         {
            _loc1_ = Appearance.getAppearanceById(this.appearanceId);
            if(_loc1_)
            {
               this._appearance = TiphonEntityLook.fromString(_loc1_.data);
            }
         }
         return this._appearance;
      }
      
      public function get recipes() : Array {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Recipe = null;
         if(!this._recipes)
         {
            _loc1_ = this.recipeIds.length;
            this._recipes = new Array();
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = Recipe.getRecipeByResultId(this.recipeIds[_loc2_]);
               if(_loc3_)
               {
                  this._recipes.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return this._recipes;
      }
      
      public function get category() : uint {
         switch(true)
         {
            case FILTER_EQUIPEMENT[this.type.superTypeId]:
               return EQUIPEMENT_CATEGORY;
            case FILTER_CONSUMABLES[this.type.superTypeId]:
               return CONSUMABLES_CATEGORY;
            case FILTER_RESSOURCES[this.type.superTypeId]:
               return RESSOURCES_CATEGORY;
            case FILTER_QUEST[this.type.superTypeId]:
               return QUEST_CATEGORY;
            default:
               return OTHER_CATEGORY;
         }
      }
      
      public function get isEquipable() : Boolean {
         return SUPERTYPE_NOT_EQUIPABLE[this.type.superTypeId];
      }
      
      public function get canEquip() : Boolean {
         var _loc1_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(!this.isEquipable)
         {
            return false;
         }
         if((_loc1_) && _loc1_.infos.level <= this.level)
         {
            return false;
         }
         return this._conditions.isRespected;
      }
      
      public function get conditions() : GroupItemCriterion {
         if(!this.criteria)
         {
            return null;
         }
         if(!this._conditions)
         {
            this._conditions = new GroupItemCriterion(this.criteria);
         }
         return this._conditions;
      }
      
      public function get targetConditions() : GroupItemCriterion {
         if(!this.criteriaTarget)
         {
            return null;
         }
         if(!this._conditionsTarget)
         {
            this._conditionsTarget = new GroupItemCriterion(this.criteriaTarget);
         }
         return this._conditionsTarget;
      }
      
      public function copy(param1:Item, param2:Item) : void {
         param2.id = param1.id;
         param2.nameId = param1.nameId;
         param2.typeId = param1.typeId;
         param2.descriptionId = param1.descriptionId;
         param2.iconId = param1.iconId;
         param2.level = param1.level;
         param2.realWeight = param1.realWeight;
         param2.weight = param1.weight;
         param2.cursed = param1.cursed;
         param2.useAnimationId = param1.useAnimationId;
         param2.usable = param1.usable;
         param2.targetable = param1.targetable;
         param2.price = param1.price;
         param2.twoHanded = param1.twoHanded;
         param2.etheral = param1.etheral;
         param2.enhanceable = param1.enhanceable;
         param2.nonUsableOnAnother = param1.nonUsableOnAnother;
         param2.itemSetId = param1.itemSetId;
         param2.criteria = param1.criteria;
         param2.criteriaTarget = param1.criteriaTarget;
         param2.hideEffects = param1.hideEffects;
         param2.appearanceId = param1.appearanceId;
         param2.recipeIds = param1.recipeIds;
         param2.recipeSlots = param1.recipeSlots;
         param2.secretRecipe = param1.secretRecipe;
         param2.bonusIsSecret = param1.bonusIsSecret;
         param2.possibleEffects = param1.possibleEffects;
         param2.favoriteSubAreas = param1.favoriteSubAreas;
         param2.favoriteSubAreasBonus = param1.favoriteSubAreasBonus;
         param2.dropMonsterIds = param1.dropMonsterIds;
         param2.exchangeable = param1.exchangeable;
      }
      
      public function postInit() : void {
         if(!_censoredIcons)
         {
            _censoredIcons = CensoredContentManager.getInstance().getCensoredIndex(1);
         }
         if(_censoredIcons[this.iconId])
         {
            this.iconId = _censoredIcons[this.iconId];
         }
      }
   }
}
