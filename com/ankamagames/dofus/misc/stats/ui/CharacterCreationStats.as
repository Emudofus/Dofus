package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.berilia.components.messages.ColorChangeMessage;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
   
   public class CharacterCreationStats extends Object implements IUiStats
   {
      
      public function CharacterCreationStats(param1:UiRootContainer)
      {
         super();
         this._ui = param1;
         this._action = StatsAction.get(StatisticTypeEnum.STEP0200_CREATE_FIRST_CHARACTER);
         this._action.addParam("Used_Name_Generator",false);
         this._action.addParam("Used_Style_Generator",false);
         this._action.addParam("Used_Proposed_Style",false);
         this._action.start();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterCreationStats));
      
      private var _action:StatsAction;
      
      private var _ui:UiRootContainer;
      
      public function process(param1:Message) : void
      {
         var _loc2_:EntityReadyMessage = null;
         var _loc3_:EntityDisplayer = null;
         var _loc4_:MouseClickMessage = null;
         var _loc5_:SelectItemMessage = null;
         switch(true)
         {
            case param1 is CharacterCreationAction:
               if(!this._action.hasParam("Gender"))
               {
                  this._action.addParam("Gender",(this._ui.getElement("btn_sex0") as ButtonContainer).selected?"M":"F");
               }
               this._action.send();
               break;
            case param1 is EntityReadyMessage:
               _loc2_ = param1 as EntityReadyMessage;
               _loc3_ = _loc2_.target as EntityDisplayer;
               this._action.addParam("Breed_ID",_loc3_.look.skins[0]);
               this._action.addParam("Face_Chosen",_loc3_.look.skins[1]);
               break;
            case param1 is CharacterNameSuggestionRequestAction:
               this._action.addParam("Used_Name_Generator",true);
               break;
            case param1 is MouseClickMessage:
               _loc4_ = param1 as MouseClickMessage;
               switch(_loc4_.target.name)
               {
                  case "btn_generateColor":
                     this._action.addParam("Used_Style_Generator",true);
                     break;
                  case "btn_reinitColor":
                     this._action.addParam("Used_Proposed_Style",false);
                     break;
                  case "btn_sex0":
                     this._action.addParam("Gender","M");
                     break;
                  case "btn_sex1":
                     this._action.addParam("Gender","F");
                     break;
               }
               break;
            case param1 is SelectItemMessage:
               _loc5_ = param1 as SelectItemMessage;
               if(_loc5_.target.name == "gd_randomColorPrevisualisation" && !(_loc5_.selectMethod == SelectMethodEnum.AUTO))
               {
                  this._action.addParam("Used_Proposed_Style",true);
               }
               break;
            case param1 is ColorChangeMessage:
               this._action.addParam("Used_Proposed_Style",false);
               break;
         }
      }
      
      public function onHook(param1:Hook, param2:Array) : void
      {
      }
      
      public function remove() : void
      {
      }
   }
}
