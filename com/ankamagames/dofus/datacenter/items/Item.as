package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.data.IPostInit;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
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
      
      private static const SUPERTYPE_NOT_EQUIPABLE:Array;
      
      private static const FILTER_EQUIPEMENT:Array;
      
      private static const FILTER_CONSUMABLES:Array;
      
      private static const FILTER_RESSOURCES:Array;
      
      private static const FILTER_QUEST:Array;
      
      public static const EQUIPEMENT_CATEGORY:uint = 0;
      
      public static const CONSUMABLES_CATEGORY:uint = 1;
      
      public static const RESSOURCES_CATEGORY:uint = 2;
      
      public static const QUEST_CATEGORY:uint = 3;
      
      public static const OTHER_CATEGORY:uint = 4;
      
      protected static const _log:Logger;
      
      public static function getItemById(id:uint, returnDefaultItemIfNull:Boolean = true) : Item {
         var item:Item = GameData.getObject(MODULE,id) as Item;
         if((item) || (!returnDefaultItemIfNull))
         {
            return item;
         }
         _log.error("Impossible de trouver l\'objet " + id + ", remplacement par l\'objet 666");
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
      
      private var _undiatricalName:String;
      
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
      
      public function get undiatricalName() : String {
         if(!this._undiatricalName)
         {
            this._undiatricalName = StringUtils.noAccent(this.name).toLowerCase();
         }
         return this._undiatricalName;
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
      
      public function set weight(n:uint) : void {
         this._weight = n;
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
         var appearance:Appearance = null;
         if(!this._appearance)
         {
            appearance = Appearance.getAppearanceById(this.appearanceId);
            if(appearance)
            {
               this._appearance = TiphonEntityLook.fromString(appearance.data);
            }
         }
         return this._appearance;
      }
      
      public function get recipes() : Array {
         var numRecipes:* = 0;
         var i:* = 0;
         var recipe:Recipe = null;
         if(!this._recipes)
         {
            numRecipes = this.recipeIds.length;
            this._recipes = new Array();
            i = 0;
            while(i < numRecipes)
            {
               recipe = Recipe.getRecipeByResultId(this.recipeIds[i]);
               if(recipe)
               {
                  this._recipes.push(recipe);
               }
               i++;
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
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(!this.isEquipable)
         {
            return false;
         }
         if((player) && (player.infos.level <= this.level))
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
      
      public function copy(from:Item, to:Item) : void {
         to.id = from.id;
         to.nameId = from.nameId;
         to.typeId = from.typeId;
         to.descriptionId = from.descriptionId;
         to.iconId = from.iconId;
         to.level = from.level;
         to.realWeight = from.realWeight;
         to.weight = from.weight;
         to.cursed = from.cursed;
         to.useAnimationId = from.useAnimationId;
         to.usable = from.usable;
         to.targetable = from.targetable;
         to.price = from.price;
         to.twoHanded = from.twoHanded;
         to.etheral = from.etheral;
         to.enhanceable = from.enhanceable;
         to.nonUsableOnAnother = from.nonUsableOnAnother;
         to.itemSetId = from.itemSetId;
         to.criteria = from.criteria;
         to.criteriaTarget = from.criteriaTarget;
         to.hideEffects = from.hideEffects;
         to.appearanceId = from.appearanceId;
         to.recipeIds = from.recipeIds;
         to.recipeSlots = from.recipeSlots;
         to.secretRecipe = from.secretRecipe;
         to.bonusIsSecret = from.bonusIsSecret;
         to.possibleEffects = from.possibleEffects;
         to.favoriteSubAreas = from.favoriteSubAreas;
         to.favoriteSubAreasBonus = from.favoriteSubAreasBonus;
         to.dropMonsterIds = from.dropMonsterIds;
         to.exchangeable = from.exchangeable;
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
