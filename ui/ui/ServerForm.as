package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.TimeApi;
    import d2api.SoundApi;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.TextArea;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.TextureLoadFailed;
    import d2hooks.*;
    import d2actions.*;

    public class ServerForm 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var timeApi:TimeApi;
        public var soundApi:SoundApi;
        private var _currentServer:Object;
        private var _currentTab:uint;
        private var _assetsUri:String;
        public var tx_serverPic:Texture;
        public var btn_story:ButtonContainer;
        public var btn_rules:ButtonContainer;
        public var lbl_nameText:Label;
        public var lbl_communityText:Label;
        public var lbl_populationText:Label;
        public var lbl_typeText:Label;
        public var lbl_stateText:Label;
        public var lbl_dateText:Label;
        public var texta_info:TextArea;


        public function main(pParam:Object=null):void
        {
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.btn_rules.soundId = SoundEnum.TAB;
            this.btn_story.soundId = SoundEnum.TAB;
            this.sysApi.addHook(TextureLoadFailed, this.onIlluLoadFailed);
            this.btn_story.selected = true;
            this._assetsUri = this.uiApi.me().getConstant("assets");
            this.texta_info.hideScroll = true;
            this.displaySelectedItem(pParam.server);
        }

        private function updateTab():void
        {
            if (this._currentTab == 0)
            {
                this.texta_info.text = this._currentServer.comment;
            }
            else
            {
                if (this._currentTab == 1)
                {
                    this.texta_info.text = this.uiApi.getText(("ui.server.rules." + this._currentServer.gameType.id));
                };
            };
        }

        private function displaySelectedItem(oServer:Object=null):void
        {
            this.tx_serverPic.dispatchMessages = true;
            if (!(this.tx_serverPic.visible))
            {
                this.tx_serverPic.visible = true;
            };
            this.tx_serverPic.finalized = true;
            this.tx_serverPic.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_") + oServer.id));
            this._currentServer = this.dataApi.getServer(oServer.id);
            this.lbl_nameText.text = this._currentServer.name;
            if (this._currentServer.community)
            {
                this.lbl_communityText.text = this._currentServer.community.name;
            }
            else
            {
                this.lbl_communityText.text = this._currentServer.communityId.toString();
            };
            if (this._currentServer.population)
            {
                this.lbl_populationText.text = this._currentServer.population.name;
            }
            else
            {
                this.lbl_populationText.text = "-";
            };
            this.lbl_typeText.text = this._currentServer.gameType.name;
            this.lbl_stateText.text = this.uiApi.me().getConstant(("status_" + oServer.status));
            this.lbl_dateText.text = this.timeApi.getDate(this._currentServer.openingDate, true, true);
            this.updateTab();
        }

        public function onServerSelected(server:Object):void
        {
            this.displaySelectedItem(server);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_rules:
                    this._currentTab = 1;
                    this.updateTab();
                    break;
                case this.btn_story:
                    this._currentTab = 0;
                    this.updateTab();
                    break;
            };
        }

        public function onIlluLoadFailed(target:Object, behavior:Object):void
        {
            if (target == this.tx_serverPic)
            {
                behavior.cancel = true;
                this.tx_serverPic.uri = this.uiApi.createUri((this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_0"));
            };
        }


    }
}//package ui

