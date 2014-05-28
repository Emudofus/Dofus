package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class MapCharactersItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function MapCharactersItemCriterion(pCriterion:String) {
         super(pCriterion);
         var params:Array = _criterionValueText.split(",");
         if(params.length == 1)
         {
            this._mapId = PlayedCharacterManager.getInstance().currentMap.mapId;
            this._nbCharacters = uint(params[0]);
         }
         else if(params.length == 2)
         {
            this._mapId = int(params[0]);
            this._nbCharacters = uint(params[1]);
         }
         
      }
      
      private var _mapId:int;
      
      private var _nbCharacters:uint;
      
      override public function get text() : String {
         var readableCriterionRef:String = I18n.getUiText("ui.criterion.MK",[this._mapId]);
         return readableCriterionRef + " " + _operator.text + " " + this._nbCharacters;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:MapCharactersItemCriterion = new MapCharactersItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().infos.level;
      }
   }
}
