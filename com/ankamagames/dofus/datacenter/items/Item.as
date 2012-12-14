package com.ankamagames.dofus.datacenter.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.appearance.*;
    import com.ankamagames.dofus.datacenter.items.criterion.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class Item extends Object implements IPostInit, IDataCenter
    {
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
        private static const MODULE:String = "Items";
        private static const SUPERTYPE_NOT_EQUIPABLE:Array = [9, 14, 15, 16, 17, 18, 6, 19, 21, 20, 8, 22];
        private static const FILTER_EQUIPEMENT:Array = [false, true, true, true, true, true, false, true, true, false, true, true, true, true, false, false, false, false, false, false, false, false, true];
        private static const FILTER_CONSUMABLES:Array = [false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
        private static const FILTER_RESSOURCES:Array = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false];
        private static const FILTER_QUEST:Array = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false];
        public static const EQUIPEMENT_CATEGORY:uint = 0;
        public static const CONSUMABLES_CATEGORY:uint = 1;
        public static const RESSOURCES_CATEGORY:uint = 2;
        public static const QUEST_CATEGORY:uint = 3;
        public static const OTHER_CATEGORY:uint = 4;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Item));
        private static var _censoredIcons:Dictionary;

        public function Item()
        {
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
                if (this.etheral)
                {
                    this._description = I18n.getUiText("ui.common.etherealWeaponDescription");
                }
                else
                {
                    this._description = I18n.getText(this.descriptionId);
                }
            }
            return this._description;
        }// end function

        public function get weight() : uint
        {
            return this._weight;
        }// end function

        public function set weight(param1:uint) : void
        {
            this._weight = param1;
            return;
        }// end function

        public function get type() : Object
        {
            if (!this._type)
            {
                this._type = ItemType.getItemTypeById(this.typeId);
            }
            return this._type;
        }// end function

        public function get isWeapon() : Boolean
        {
            return false;
        }// end function

        public function get itemSet() : ItemSet
        {
            if (!this._itemSet)
            {
                this._itemSet = ItemSet.getItemSetById(this.itemSetId);
            }
            return this._itemSet;
        }// end function

        public function get appearance() : TiphonEntityLook
        {
            var _loc_1:* = null;
            if (!this._appearance)
            {
                _loc_1 = Appearance.getAppearanceById(this.appearanceId);
                if (_loc_1)
                {
                    this._appearance = TiphonEntityLook.fromString(_loc_1.data);
                }
            }
            return this._appearance;
        }// end function

        public function get recipes() : Array
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (!this._recipes)
            {
                _loc_1 = this.recipeIds.length;
                this._recipes = new Array();
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = Recipe.getRecipeByResultId(this.recipeIds[_loc_2]);
                    if (_loc_3)
                    {
                        this._recipes.push(_loc_3);
                    }
                    _loc_2++;
                }
            }
            return this._recipes;
        }// end function

        public function get category() : uint
        {
            switch(true)
            {
                case FILTER_EQUIPEMENT[this.type.superTypeId]:
                {
                    return EQUIPEMENT_CATEGORY;
                }
                case FILTER_CONSUMABLES[this.type.superTypeId]:
                {
                    return CONSUMABLES_CATEGORY;
                }
                case FILTER_RESSOURCES[this.type.superTypeId]:
                {
                    return RESSOURCES_CATEGORY;
                }
                case FILTER_QUEST[this.type.superTypeId]:
                {
                    return QUEST_CATEGORY;
                }
                default:
                {
                    break;
                }
            }
            return OTHER_CATEGORY;
        }// end function

        public function get isEquipable() : Boolean
        {
            return SUPERTYPE_NOT_EQUIPABLE[this.type.superTypeId];
        }// end function

        public function get canEquip() : Boolean
        {
            var _loc_1:* = PlayedCharacterManager.getInstance();
            if (!this.isEquipable)
            {
                return false;
            }
            if (_loc_1 && _loc_1.infos.level <= this.level)
            {
                return false;
            }
            return this._conditions.isRespected;
        }// end function

        public function get conditions() : GroupItemCriterion
        {
            if (!this.criteria)
            {
                return null;
            }
            if (!this._conditions)
            {
                this._conditions = new GroupItemCriterion(this.criteria);
            }
            return this._conditions;
        }// end function

        public function get targetConditions() : GroupItemCriterion
        {
            if (!this.criteriaTarget)
            {
                return null;
            }
            if (!this._conditionsTarget)
            {
                this._conditionsTarget = new GroupItemCriterion(this.criteriaTarget);
            }
            return this._conditionsTarget;
        }// end function

        public function copy(param1:Item, param2:Item) : void
        {
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
            param2.secretRecipe = param1.secretRecipe;
            param2.bonusIsSecret = param1.bonusIsSecret;
            param2.possibleEffects = param1.possibleEffects;
            param2.favoriteSubAreas = param1.favoriteSubAreas;
            param2.favoriteSubAreasBonus = param1.favoriteSubAreasBonus;
            return;
        }// end function

        public function postInit() : void
        {
            if (!_censoredIcons)
            {
                _censoredIcons = CensoredContentManager.getInstance().getCensoredIndex(1);
            }
            if (_censoredIcons[this.iconId])
            {
                this.iconId = _censoredIcons[this.iconId];
            }
            return;
        }// end function

        public static function getItemById(param1:uint) : Item
        {
            var _loc_2:* = GameData.getObject(MODULE, param1) as Item;
            if (_loc_2)
            {
                return _loc_2;
            }
            _log.error("Impossible de trouver l\'objet " + param1 + ", remplacement par l\'objet 666");
            return GameData.getObject(MODULE, 666) as Item;
        }// end function

        public static function getItems() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
