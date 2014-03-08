package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   
   public class ItemCriterion extends Object implements IItemCriterion, IDataCenter
   {
      
      public function ItemCriterion(param1:String) {
         super();
         this._serverCriterionForm = param1;
         this.getInfos();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemCriterion));
      
      protected var _serverCriterionForm:String;
      
      protected var _operator:ItemCriterionOperator;
      
      protected var _criterionRef:String;
      
      protected var _criterionValue:int;
      
      protected var _criterionValueText:String;
      
      public function get inlineCriteria() : Vector.<IItemCriterion> {
         var _loc1_:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         _loc1_.push(this);
         return _loc1_;
      }
      
      public function get criterionValue() : Object {
         return this._criterionValue;
      }
      
      public function get isRespected() : Boolean {
         var _loc1_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(!_loc1_ || !_loc1_.characteristics)
         {
            return true;
         }
         return this._operator.compare(this.getCriterion(),this._criterionValue);
      }
      
      public function get text() : String {
         var _loc1_:String = null;
         switch(this._criterionRef)
         {
            case "CM":
               _loc1_ = I18n.getUiText("ui.stats.movementPoints");
               break;
            case "CP":
               _loc1_ = I18n.getUiText("ui.stats.actionPoints");
               break;
            case "CH":
               _loc1_ = I18n.getUiText("ui.pvp.honourPoints");
               break;
            case "CD":
               _loc1_ = I18n.getUiText("ui.pvp.disgracePoints");
               break;
            case "CT":
               _loc1_ = I18n.getUiText("ui.stats.takleBlock");
               break;
            case "Ct":
               _loc1_ = I18n.getUiText("ui.stats.takleEvade");
               break;
            default:
               _loc1_ = StringUtils.replace(this._criterionRef,["CS","Cs","CV","Cv","CA","Ca","CI","Ci","CW","Cw","CC","Cc","CA","PG","PJ","Pj","PM","PA","PN","PE","<NO>","PS","PR","PL","PK","Pg","Pr","Ps","Pa","PP","PZ","CM","Qa"],I18n.getUiText("ui.item.characteristics").split(","));
         }
         return _loc1_ + " " + this._operator.text + " " + this._criterionValue;
      }
      
      public function get basicText() : String {
         return this._serverCriterionForm;
      }
      
      public function clone() : IItemCriterion {
         var _loc1_:IItemCriterion = new ItemCriterion(this.basicText);
         return _loc1_;
      }
      
      protected function getInfos() : void {
         var _loc1_:String = null;
         for each (_loc1_ in ItemCriterionOperator.OPERATORS_LIST)
         {
            if(this._serverCriterionForm.indexOf(_loc1_) == 2)
            {
               this._operator = new ItemCriterionOperator(_loc1_);
               this._criterionRef = this._serverCriterionForm.split(_loc1_)[0];
               this._criterionValue = this._serverCriterionForm.split(_loc1_)[1];
               this._criterionValueText = this._serverCriterionForm.split(_loc1_)[1];
            }
         }
      }
      
      protected function getCriterion() : int {
         var _loc1_:* = 0;
         var _loc2_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         switch(this._criterionRef)
         {
            case "Ca":
               _loc1_ = _loc2_.characteristics.agility.base;
               break;
            case "CA":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.agility);
               break;
            case "Cc":
               _loc1_ = _loc2_.characteristics.chance.base;
               break;
            case "CC":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.chance);
               break;
            case "Ce":
               _loc1_ = _loc2_.characteristics.energyPoints;
               break;
            case "CE":
               _loc1_ = _loc2_.characteristics.maxEnergyPoints;
               break;
            case "CH":
               _loc1_ = _loc2_.characteristics.alignmentInfos.honor;
               break;
            case "Ci":
               _loc1_ = _loc2_.characteristics.intelligence.base;
               break;
            case "CI":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.intelligence);
               break;
            case "CL":
               _loc1_ = _loc2_.characteristics.lifePoints;
               break;
            case "CM":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.movementPoints);
               break;
            case "CP":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.actionPoints);
               break;
            case "Cs":
               _loc1_ = _loc2_.characteristics.strength.base;
               break;
            case "CS":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.strength);
               break;
            case "Cv":
               _loc1_ = _loc2_.characteristics.vitality.base;
               break;
            case "CV":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.vitality);
               break;
            case "Cw":
               _loc1_ = _loc2_.characteristics.wisdom.base;
               break;
            case "CW":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.wisdom);
               break;
            case "Ct":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.tackleEvade);
               break;
            case "CT":
               _loc1_ = this.getTotalCharac(_loc2_.characteristics.tackleBlock);
               break;
         }
         return _loc1_;
      }
      
      private function getTotalCharac(param1:CharacterBaseCharacteristic) : int {
         return param1.base + param1.alignGiftBonus + param1.contextModif + param1.objectsAndMountBonus;
      }
   }
}
