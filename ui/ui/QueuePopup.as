package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2hooks.LoginQueueStatus;
    import d2hooks.QueueStatus;
    import d2actions.ResetGame;
    import d2actions.ChangeServer;
    import d2hooks.*;
    import d2actions.*;

    public class QueuePopup 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var lbl_text2:Label;
        public var btn_back:ButtonContainer;


        public function main(param:Array):void
        {
            this.sysApi.addHook(LoginQueueStatus, this.onLoginQueueStatus);
            this.sysApi.addHook(QueueStatus, this.onQueueStatus);
            if (param[2])
            {
                this.updateLoginQueue(param[0], param[1]);
            }
            else
            {
                this.updateQueue(param[0], param[1]);
            };
        }

        public function unload():void
        {
        }

        private function updateQueue(position:uint, total:uint):void
        {
            this.lbl_text2.text = ((this.uiApi.getText("ui.queue.number", position, total) + "\n") + this.uiApi.getText("ui.queue.server", this.sysApi.getCurrentServer().name));
        }

        private function updateLoginQueue(position:uint, total:uint):void
        {
            this.lbl_text2.text = this.uiApi.getText("ui.queue.number", position, total);
        }

        public function onLoginQueueStatus(nPosition:uint, nTotal:uint):void
        {
            if (nPosition < 1)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                this.updateLoginQueue(nPosition, nTotal);
            };
        }

        public function onQueueStatus(nPosition:uint, nTotal:uint):void
        {
            if (nPosition < 1)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                this.updateQueue(nPosition, nTotal);
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_back:
                    if (((((((!(this.uiApi.getUi("serverSelection"))) && (!(this.uiApi.getUi("serverListSelection"))))) && (!(this.uiApi.getUi("serverSimpleSelection"))))) && (!(this.uiApi.getUi("characterCreation")))))
                    {
                        this.sysApi.sendAction(new ResetGame());
                    }
                    else
                    {
                        this.sysApi.sendAction(new ChangeServer());
                    };
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            return (false);
        }


    }
}//package ui

