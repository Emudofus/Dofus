package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class MapCharactersItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function MapCharactersItemCriterion(param1:String)
      {
         super(param1);
         var _loc2_:Array = _criterionValueText.split(",");
         if(_loc2_.length == 1)
         {
            this._mapId = PlayedCharacterManager.getInstance().currentMap.mapId;
            this._nbCharacters = uint(_loc2_[0]);
         }
         else if(_loc2_.length == 2)
         {
            this._mapId = int(_loc2_[0]);
            this._nbCharacters = uint(_loc2_[1]);
         }
         
      }
      
      private var _mapId:int;
      
      private var _nbCharacters:uint;
      
      override public function get text() : String
      {
         var _loc1_:String = I18n.getUiText("ui.criterion.MK",[this._mapId]);
         return _loc1_ + " " + _operator.text + " " + this._nbCharacters;
      }
      
      override public function clone() : IItemCriterion
      {
         var _loc1_:MapCharactersItemCriterion = new MapCharactersItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int
      {
         var _loc1_:* = 0;
         var _loc3_:Dictionary = null;
         var _loc4_:GameContextActorInformations = null;
         var _loc2_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_loc2_)
         {
            _loc3_ = _loc2_.getEntitiesDictionnary();
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_ is GameRolePlayCharacterInformations)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
   }
}
