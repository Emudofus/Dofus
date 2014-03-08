package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SpellItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SpellItemCriterion(pCriterion:String) {
         super(pCriterion);
         var arrayParams:Array = String(_criterionValueText).split(",");
         if((arrayParams) && (arrayParams.length > 0))
         {
            if(arrayParams.length > 1)
            {
               trace("Les paramètres pour le sort sont mauvais ! (" + _serverCriterionForm + ")");
            }
            else
            {
               this._spellId = uint(arrayParams[0]);
            }
         }
         else
         {
            this._spellId = uint(_criterionValue);
         }
      }
      
      private var _spellId:uint;
      
      override public function get isRespected() : Boolean {
         var sp:SpellWrapper = null;
         for each (sp in PlayedCharacterManager.getInstance().playerSpellList)
         {
            if(sp.id == this._spellId)
            {
               if(_operator.text == ItemCriterionOperator.EQUAL)
               {
                  return true;
               }
               return false;
            }
         }
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            return true;
         }
         return false;
      }
      
      override public function get text() : String {
         var readableCriterionRef:String = "";
         var readableCriterion:String = "";
         var spell:Spell = Spell.getSpellById(this._spellId);
         if(!spell)
         {
            return readableCriterion;
         }
         var readableCriterionValue:String = spell.name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.gotSpell",[readableCriterionValue]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.doesntGotSpell",[readableCriterionValue]);
               break;
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:SpellItemCriterion = new SpellItemCriterion(this.basicText);
         return clonedCriterion;
      }
   }
}
