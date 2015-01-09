package 
{
    import flash.display.Sprite;
    import ui.TipsUi;
    import ui.TutorialUi;
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.PlayedCharacterApi;
    import d2api.QuestApi;
    import d2api.DataApi;
    import d2api.MapApi;
    import d2api.HighlightApi;
    import d2api.FightApi;
    import d2api.StorageApi;
    import d2api.BindsApi;
    import d2hooks.GameStart;
    import d2hooks.Notification;
    import d2hooks.NotificationReset;
    import d2hooks.RefreshTips;
    import d2hooks.CurrentMap;
    import d2hooks.QuestListUpdated;
    import d2hooks.QuestValidated;
    import d2enums.BuildTypeEnum;
    import d2hooks.UiLoaded;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import managers.TutorialStepManager;
    import d2actions.QuestListRequest;
    import d2hooks.*;
    import d2actions.*;

    public class Tutorial extends Sprite 
    {

        public const SUPERAREA_INCARNAM:uint = 3;
        public const MAP_REFERENCE_TUTORIAL:uint = 12;
        public const MAX_CHARACTER_LEVEL_FOR_TUTORIAL:uint = 14;

        private var include_TipsUi:TipsUi;
        private var include_TutorialUi:TutorialUi;
        [Module(name="Ankama_ContextMenu")]
        public var modMenu:Object;
        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var playerApi:PlayedCharacterApi;
        public var questApi:QuestApi;
        public var dataApi:DataApi;
        public var mapApi:MapApi;
        public var highlightApi:HighlightApi;
        public var fightApi:FightApi;
        public var storageApi:StorageApi;
        public var bindsApi:BindsApi;
        private var _subArea:Object;
        private var _showTutorial:Boolean = false;
        private var _questListUpdated:Boolean = false;


        public function main():void
        {
            Api.ui = this.uiApi;
            Api.system = this.sysApi;
            Api.modMenu = this.modMenu;
            Api.player = this.playerApi;
            Api.data = this.dataApi;
            Api.highlight = this.highlightApi;
            Api.fight = this.fightApi;
            Api.storage = this.storageApi;
            Api.binds = this.bindsApi;
            this.sysApi.createHook("RefreshTips");
            this.sysApi.addHook(GameStart, this.onGameStart);
            this.sysApi.addHook(Notification, this.onNotification);
            this.sysApi.addHook(NotificationReset, this.resetTips);
            this.sysApi.addHook(RefreshTips, this.onGameStart);
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.sysApi.addHook(QuestListUpdated, this.onQuestListUpdated);
            this.sysApi.addHook(QuestValidated, this.onQuestValidated);
            if (this.sysApi.getBuildType() == BuildTypeEnum.INTERNAL)
            {
                this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            };
        }

        private function onGameStart(... args):void
        {
            if (!(this.uiApi.getUi("tips")))
            {
                (this.uiApi.loadUi("tips", "tips", [], 3) as TipsUi);
            }
            else
            {
                this.uiApi.getUi("tips").uiClass.checkQuietMode();
            };
        }

        private function resetTips(... args):void
        {
            var notifications:Object = this.questApi.getNotificationList();
            if (notifications)
            {
                this.uiApi.getUi("tips").uiClass.resetTips(notifications);
            };
            this.onGameStart();
        }

        private function onNotification(pNotification:Object):void
        {
            if (!(this.uiApi.getUi("tips")))
            {
                this.uiApi.loadUi("tips", "tips", [pNotification], 3);
            };
        }

        private function onUiLoaded(name:String):void
        {
            if (name == UIEnum.BANNER)
            {
                TutorialStepManager.getInstance().preload();
            };
        }

        private function onCurrentMap(mapId:uint):void
        {
            this._subArea = this.mapApi.subAreaByMapId(mapId);
            if (((this._subArea) && ((this._subArea.id == 536))))
            {
                if (this.uiApi.getUi(UIEnum.TUTORIAL_UI))
                {
                    if (!(this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.visible))
                    {
                        this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.displayTutorial();
                    };
                }
                else
                {
                    this.uiApi.loadUi(UIEnum.TUTORIAL_UI, UIEnum.TUTORIAL_UI, [true]);
                };
            }
            else
            {
                if (((this._subArea) && ((this._subArea.area.superArea.id == this.SUPERAREA_INCARNAM))))
                {
                    if (this.uiApi.getUi(UIEnum.TUTORIAL_UI))
                    {
                        if (this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.visible)
                        {
                            this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.closeTutorial();
                        };
                    }
                    else
                    {
                        this.showTutorialInIncarnam();
                    };
                }
                else
                {
                    if (this.uiApi.getUi(UIEnum.TUTORIAL_UI))
                    {
                        this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
                    };
                };
            };
        }

        private function onQuestListUpdated():void
        {
            var questId:uint;
            var completedQuests:Object = this.questApi.getCompletedQuests();
            this._questListUpdated = true;
            this._showTutorial = true;
            for each (questId in completedQuests)
            {
                if (questId == TutorialConstants.QUEST_TUTORIAL_ID)
                {
                    this._showTutorial = false;
                    if (this.uiApi.getUi(UIEnum.TUTORIAL_UI))
                    {
                        this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
                    };
                };
            };
            this.showTutorialInIncarnam();
        }

        private function onQuestValidated(questId:int):void
        {
            if (questId == TutorialConstants.QUEST_TUTORIAL_ID)
            {
                this._questListUpdated = true;
                this._showTutorial = false;
                if (this.uiApi.getUi(UIEnum.TUTORIAL_UI))
                {
                    this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
                };
            };
        }

        private function showTutorialInIncarnam():void
        {
            if (this._questListUpdated)
            {
                if (((((((this._showTutorial) && (this._subArea))) && ((this._subArea.area.superArea.id == this.SUPERAREA_INCARNAM)))) && (!(this.uiApi.getUi(UIEnum.TUTORIAL_UI)))))
                {
                    this.uiApi.loadUi(UIEnum.TUTORIAL_UI, UIEnum.TUTORIAL_UI, [false]);
                };
            }
            else
            {
                this.sysApi.sendAction(new QuestListRequest());
            };
        }


    }
}//package 

