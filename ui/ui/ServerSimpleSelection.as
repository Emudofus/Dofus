package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ConnectionApi;
    import d2api.SoundApi;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.SelectedServerRefused;
    import d2hooks.UiUnloaded;
    import d2actions.ServerSelection;
    import d2hooks.ServerSelectionStart;
    import d2hooks.*;
    import d2actions.*;

    public class ServerSimpleSelection 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var connecApi:ConnectionApi;
        public var soundApi:SoundApi;
        public var btn_autochoice:ButtonContainer;
        public var btn_mychoice:ButtonContainer;


        public function main(param:Object=null):void
        {
            var serverInfos:*;
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.btn_mychoice.soundId = SoundEnum.CANCEL_BUTTON;
            this.btn_autochoice.soundId = "-1";
            this.sysApi.addHook(SelectedServerRefused, this.onSelectedServerRefused);
            this.sysApi.addHook(UiUnloaded, this.onUiUnloaded);
            if (this.sysApi.isInForcedGuestMode())
            {
                serverInfos = this.connecApi.getAutochosenServer();
                if (serverInfos)
                {
                    this.sysApi.sendAction(new ServerSelection(serverInfos.id));
                    this.btn_mychoice.disabled = true;
                    this.btn_autochoice.disabled = true;
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:Object;
            switch (target)
            {
                case this.btn_mychoice:
                    this.sysApi.dispatchHook(ServerSelectionStart, [1, Connection.waitingForCreation]);
                    break;
                case this.btn_autochoice:
                    _local_2 = this.connecApi.getAutochosenServer();
                    if (_local_2)
                    {
                        if (!(this.uiApi.getUi("serverPopup")))
                        {
                            this.uiApi.loadUi("serverPopup", "serverPopup", [_local_2]);
                        };
                        this.btn_autochoice.disabled = true;
                        this.btn_mychoice.disabled = true;
                    }
                    else
                    {
                        this.sysApi.log(2, "Impossible de selectionner un serveur");
                    };
                    break;
            };
        }

        public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Object):void
        {
            this.btn_mychoice.disabled = false;
            this.btn_autochoice.disabled = false;
        }

        private function onUiUnloaded(name:String):void
        {
            if (name == "serverPopup")
            {
                this.btn_autochoice.disabled = false;
                this.btn_mychoice.disabled = false;
            };
        }


    }
}//package ui

