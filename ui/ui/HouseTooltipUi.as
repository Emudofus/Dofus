package ui
{
    import flash.utils.Timer;
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2components.Label;
    import d2components.Texture;
    import d2data.GuildWrapper;
    import flash.events.TimerEvent;
    import d2data.EmblemSymbol;
    import d2hooks.*;

    public class HouseTooltipUi 
    {

        private var _timerHide:Timer;
        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        public var lbl_guildName:Label;
        public var lbl_ownerName:Label;
        public var lbl_price:Label;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        private var _guild:GuildWrapper;


        public function main(oParam:Object=null):void
        {
            var data:Object = oParam.data;
            if (((((data.ownerName) && (!((data.ownerName == ""))))) && (!((data.ownerName == "?")))))
            {
                if (data.ownerName == Api.system.getPlayerManager().nickname)
                {
                    this.lbl_ownerName.text = this.uiApi.getText("ui.common.myHouse");
                }
                else
                {
                    this.lbl_ownerName.text = this.uiApi.getText("ui.common.houseOwnerName", data.ownerName);
                };
            }
            else
            {
                this.lbl_ownerName.text = this.uiApi.getText("ui.common.houseWithNoOwner");
            };
            if (this.lbl_price)
            {
                this.lbl_price.visible = ((data.isOnSale) || (data.isSaleLocked));
            };
            this._guild = data.guildIdentity;
            if (this._guild)
            {
                this.tx_emblemBack.visible = false;
                this.tx_emblemBack.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_emblemBack, "onTextureReady");
                this.tx_emblemBack.uri = this._guild.backEmblem.fullSizeIconUri;
                this.tx_emblemUp.visible = true;
                this.tx_emblemUp.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_emblemUp, "onTextureReady");
                this.tx_emblemUp.uri = this._guild.upEmblem.fullSizeIconUri;
                this.lbl_guildName.text = this._guild.guildName;
            };
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
            if (oParam.autoHide)
            {
                this._timerHide = new Timer(2500);
                this._timerHide.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.start();
            };
        }

        private function onTimer(e:TimerEvent):void
        {
            this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.uiApi.hideTooltip(this.uiApi.me().name);
        }

        public function unload():void
        {
            if (this._timerHide)
            {
                this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.stop();
                this._timerHide = null;
            };
        }

        public function onTextureReady(target:Object):void
        {
            var _local_2:EmblemSymbol;
            switch (target)
            {
                case this.tx_emblemBack:
                    this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"), this._guild.backEmblem.color, 1);
                    this.tx_emblemBack.visible = true;
                    break;
                case this.tx_emblemUp:
                    _local_2 = this.dataApi.getEmblemSymbol(this._guild.upEmblem.idEmblem);
                    if (_local_2.colorizable)
                    {
                        this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._guild.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._guild.upEmblem.color, 0, true);
                    };
                    break;
            };
        }


    }
}//package ui

