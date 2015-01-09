package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.network.enums.StatisticTypeEnum;
    import com.ankamagames.berilia.components.messages.EntityReadyMessage;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.berilia.components.messages.SelectItemMessage;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
    import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.berilia.components.messages.ColorChangeMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class CharacterCreationStats implements IUiStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterCreationStats));

        private var _action:StatsAction;
        private var _ui:UiRootContainer;

        public function CharacterCreationStats(pUi:UiRootContainer)
        {
            this._ui = pUi;
            this._action = StatsAction.get(StatisticTypeEnum.STEP0200_CREATE_FIRST_CHARACTER);
            this._action.addParam("Used_Name_Generator", false);
            this._action.addParam("Used_Style_Generator", false);
            this._action.addParam("Used_Proposed_Style", false);
            this._action.start();
        }

        public function process(pMessage:Message):void
        {
            var _local_2:EntityReadyMessage;
            var _local_3:EntityDisplayer;
            var _local_4:MouseClickMessage;
            var _local_5:SelectItemMessage;
            switch (true)
            {
                case (pMessage is CharacterCreationAction):
                    if (!(this._action.hasParam("Gender")))
                    {
                        this._action.addParam("Gender", (((this._ui.getElement("btn_sex0") as ButtonContainer).selected) ? "M" : "F"));
                    };
                    this._action.send();
                    return;
                case (pMessage is EntityReadyMessage):
                    _local_2 = (pMessage as EntityReadyMessage);
                    _local_3 = (_local_2.target as EntityDisplayer);
                    this._action.addParam("Breed_ID", _local_3.look.skins[0]);
                    this._action.addParam("Face_Chosen", _local_3.look.skins[1]);
                    return;
                case (pMessage is CharacterNameSuggestionRequestAction):
                    this._action.addParam("Used_Name_Generator", true);
                    return;
                case (pMessage is MouseClickMessage):
                    _local_4 = (pMessage as MouseClickMessage);
                    switch (_local_4.target.name)
                    {
                        case "btn_generateColor":
                            this._action.addParam("Used_Style_Generator", true);
                            break;
                        case "btn_reinitColor":
                            this._action.addParam("Used_Proposed_Style", false);
                            break;
                        case "btn_sex0":
                            this._action.addParam("Gender", "M");
                            break;
                        case "btn_sex1":
                            this._action.addParam("Gender", "F");
                            break;
                    };
                    return;
                case (pMessage is SelectItemMessage):
                    _local_5 = (pMessage as SelectItemMessage);
                    if ((((_local_5.target.name == "gd_randomColorPrevisualisation")) && (!((_local_5.selectMethod == SelectMethodEnum.AUTO)))))
                    {
                        this._action.addParam("Used_Proposed_Style", true);
                    };
                    return;
                case (pMessage is ColorChangeMessage):
                    this._action.addParam("Used_Proposed_Style", false);
                    return;
            };
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function remove():void
        {
        }


    }
}//package com.ankamagames.dofus.misc.stats.ui

