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
      
      public function CharacterCreationStats(pUi:UiRootContainer) {
         super();
         this._ui = pUi;
         this._action = StatsAction.get(StatisticTypeEnum.STEP0200_CREATE_FIRST_CHARACTER);
         this._action.addParam("Used_Name_Generator",false);
         this._action.addParam("Used_Style_Generator",false);
         this._action.addParam("Used_Proposed_Style",false);
         this._action.start();
      }
      
      private static const _log:Logger;
      
      private var _action:StatsAction;
      
      private var _ui:UiRootContainer;
      
      public function process(pMessage:Message) : void {
         var ermsg:EntityReadyMessage = null;
         var entityDisplay:EntityDisplayer = null;
         var mcmsg:MouseClickMessage = null;
         var simsg:SelectItemMessage = null;
         switch(true)
         {
            case pMessage is CharacterCreationAction:
               if(!this._action.hasParam("Gender"))
               {
                  this._action.addParam("Gender",(this._ui.getElement("btn_sex0") as ButtonContainer).selected?"M":"F");
               }
               this._action.send();
               break;
            case pMessage is EntityReadyMessage:
               ermsg = pMessage as EntityReadyMessage;
               entityDisplay = ermsg.target as EntityDisplayer;
               this._action.addParam("Breed_ID",entityDisplay.look.skins[0]);
               this._action.addParam("Face_Chosen",entityDisplay.look.skins[1]);
               break;
            case pMessage is CharacterNameSuggestionRequestAction:
               this._action.addParam("Used_Name_Generator",true);
               break;
            case pMessage is MouseClickMessage:
               mcmsg = pMessage as MouseClickMessage;
               switch(mcmsg.target.name)
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
            case pMessage is SelectItemMessage:
               simsg = pMessage as SelectItemMessage;
               if((simsg.target.name == "gd_randomColorPrevisualisation") && (!(simsg.selectMethod == SelectMethodEnum.AUTO)))
               {
                  this._action.addParam("Used_Proposed_Style",true);
               }
               break;
            case pMessage is ColorChangeMessage:
               this._action.addParam("Used_Proposed_Style",false);
               break;
         }
      }
      
      public function onHook(pHook:Hook, pArgs:Array) : void {
      }
      
      public function remove() : void {
      }
   }
}
